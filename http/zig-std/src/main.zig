const std = @import("std");

const http = std.http;
const Server = http.Server;
const Connection = http.Connection;
const Client = http.Client;

fn handleRequest(res: *Server.Response) !void {
    try res.do();
    try res.writeAll("hello");
    try res.finish();
}

pub fn main() !void {
    const port = 8080;
    const host = "127.0.0.1";
    const address = try std.net.Address.parseIp(host, port);
    var http_server = try address.listen(.{
        .reuse_address = true,
    });
    var read_buffer: [2048]u8 = undefined;
    while (true) {
        const connection = try http_server.accept();
        defer connection.stream.close();
        var server = std.http.Server.init(connection, &read_buffer);

        var request = try server.receiveHead();
        const server_body: []const u8 = "hello";

        try request.respond(server_body, .{
            .extra_headers = &.{
                .{ .name = "content_type", .value = "text/plain" },
                .{ .name = "connection", .value = "close" },
            },
        });
    }
}
