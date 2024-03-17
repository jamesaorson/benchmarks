using Microsoft.AspNetCore.Builder;

var builder = WebApplication.CreateBuilder(args);
builder.Logging.AddFilter((category, logLevel) =>
    category == "Microsoft.AspNetCore.Hosting.Diagnostics" && logLevel == LogLevel.Error);

var app = builder.Build();
app.MapGet("/", () => "hello");
app.Urls.Add("http://localhost:8080");
app.Run();
