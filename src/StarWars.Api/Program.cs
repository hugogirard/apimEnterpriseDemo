var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle

builder.Services.AddDbContext<StarWarsContext>(opt => opt.UseInMemoryDatabase("StarWars"));
builder.Services.AddHealthChecks();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Seed the database
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var context = services.GetRequiredService<StarWarsContext>();
    DatabaseHelper.Seed(context);
}

app.UseSwagger();
app.UseSwaggerUI(options => 
{
    options.SwaggerEndpoint("/swagger/v1/swagger.yaml", "Star Wars API");
    options.RoutePrefix = string.Empty;    
});

app.UseHttpsRedirection();

app.MapGet("/api/all", async (StarWarsContext context) =>
{
    return await context.Characters
                        .Include(c => c.Planet)
                        .Include(c => c.Affiliation)
                        .Select(c => new CharactersDTO
                        {
                            Id = c.Id,
                            Name = c.Name,
                            Planet = c.Planet.Name,
                            Affiliation = c.Affiliation.Name
                        })         
                        .AsNoTracking()
                        .ToListAsync();
})
.WithName("GetAllCharacters")
.Produces<IEnumerable<CharactersDTO>>(StatusCodes.Status200OK)
.WithOpenApi();

app.MapHealthChecks("/healthz");

app.Run();
