namespace StarWars.Api.Infrastructure;

public class DatabaseHelper 
{
    public static void Seed(StarWarsContext context) 
    {
        Planet tatooine = new () { Name = "Tatooine" };

        context.Database.EnsureCreated();
        if (!context.Planets.Any())
        {
            context.Planets.AddRange(tatooine);            
            //context.SaveChanges();
        }

        Affiliation jedi = new () { Name = "Jedi" };
        Affiliation sith = new () { Name = "Sith" };

        if (!context.Affiliations.Any())
        {
            context.Affiliations.AddRange(jedi, sith);
            //context.SaveChanges();
        }

        if (!context.Characters.Any())
        {
            context.Characters.AddRange(
                new Character { Name = "Luke Skywalker", Planet = tatooine, Affiliation = jedi },
                new Character { Name = "Darth Vader", Planet = tatooine, Affiliation = sith }
            );
            context.SaveChanges();
        }
    }
}