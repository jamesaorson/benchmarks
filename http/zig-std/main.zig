const std = @import("std");

const http = std.http;
const Server = http.Server;
const Client = http.Client;

const mem = std.mem;
const testing = std.testing;

const max_header_size = 8192;

var gpa_server = std.heap.GeneralPurposeAllocator(.{ .stack_trace_frames = 12 }){};
var gpa_client = std.heap.GeneralPurposeAllocator(.{ .stack_trace_frames = 12 }){};

const salloc = gpa_server.allocator();
const calloc = gpa_client.allocator();

var server: Server = undefined;

fn handleRequest(res: *Server.Response) !void {
    try res.do();
    try res.writeAll("hello");
    try res.finish();
}

var handle_new_requests = true;

fn runServer(srv: *Server) !void {
    outer: while (handle_new_requests) {
        var res = try srv.accept(.{
            .allocator = salloc,
            .header_strategy = .{ .dynamic = max_header_size },
        });
        defer res.deinit();

        while (res.reset() != .closing) {
            res.wait() catch |err| switch (err) {
                error.HttpHeadersInvalid => continue :outer,
                error.EndOfStream => continue,
                else => return err,
            };

            try handleRequest(&res);
        }
    }
}

fn serve(srv: *Server) void {
    defer srv.deinit();
    defer _ = gpa_server.deinit();

    runServer(srv) catch |err| {
        std.debug.print("server error: {}\n", .{err});

        if (@errorReturnTrace()) |trace| {
            std.debug.dumpStackTrace(trace.*);
        }

        _ = gpa_server.deinit();
        std.os.exit(1);
    };
}

fn killServer(addr: std.net.Address) void {
    handle_new_requests = false;

    const conn = std.net.tcpConnectToAddress(addr) catch return;
    conn.close();
}

pub fn main() !void {
    defer _ = gpa_client.deinit();

    server = Server.init(.{ .gpa = salloc, .reuse_address = true });

    const addr = std.net.Address.parseIp("127.0.0.1", 8080) catch unreachable;
    try server.listen(addr);

    serve(server);
}
