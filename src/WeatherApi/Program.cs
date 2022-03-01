using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddSingleton<ICityRepository,CityRepository>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options => 
{
    options.SwaggerDoc("v1", new OpenApiInfo()
    {
        Description = "Weather API",
        Title = "Weather API",
        Version = "v1"        
    });
});

var app = builder.Build();

app.UseSwagger(c => 
{
    c.PreSerializeFilters.Add((swagger, httpReq) => 
    {
        swagger.Servers = new List<OpenApiServer>
        {
            new OpenApiServer 
            { 
                Url = $"{httpReq.Scheme}://{httpReq.Host.Value}"
            }
        };
    });
});
app.UseSwaggerUI(c => 
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json","Weather API v1");
    c.RoutePrefix = string.Empty;
});

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/api/getForecastCities", async (ICityRepository repository) => 
{
    var cities = await repository.AllAsync();

    return cities;
});

// app.MapGet("/weatherforecast", () =>
// {
//     var forecast =  Enumerable.Range(1, 5).Select(index =>
//         new WeatherForecast
//         (
//             DateTime.Now.AddDays(index),
//             Random.Shared.Next(-20, 55),
//             summaries[Random.Shared.Next(summaries.Length)]
//         ))
//         .ToArray();
//     return forecast;
// })
// .WithName("GetWeatherForecast");

app.Run();

record WeatherForecast(DateTime Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}