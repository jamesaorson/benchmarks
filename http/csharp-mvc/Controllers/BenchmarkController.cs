using Microsoft.AspNetCore.Mvc;

namespace csharp_mvc.Controllers;

[ApiController]
[Route("[controller]")]
public class BenchmarkController : ControllerBase
{
    [HttpGet("/")]
    public string Get()
    {
        return "hello";
    }
}
