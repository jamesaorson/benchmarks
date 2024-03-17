var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Logging.AddFilter((category, level) =>
    category == "Microsoft.AspNetCore.Hosting.Diagnostics" && level == LogLevel.Error);

var app = builder.Build();
app.MapControllers();
app.Urls.Add("http://localhost:8080");
app.Run();
