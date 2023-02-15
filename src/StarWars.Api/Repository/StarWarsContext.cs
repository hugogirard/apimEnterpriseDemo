namespace StarWars.Api.Repository;

public class StarWarsContext : DbContext 
{
    public DbSet<Character> Characters { get; set; }

    public DbSet<Affiliation> Affiliations { get; set; }

    public DbSet<Planet> Planets { get; set; }

    public StarWarsContext(DbContextOptions<StarWarsContext> options) : base(options)
    {
        
    }
}