namespace StarWars.Api.Model;

public class Character 
{
    public int Id { get; set; }

    public string Name { get; set; }

    public int PlanetId { get; set; }

    public Planet Planet { get; set; }

    public int AffiliationId { get; set; }

    public Affiliation Affiliation { get; set; }
}