namespace WeatherApi.Repository;

public class CityRepository : ICityRepository
{
    public Task<List<City>> AllAsync()
    {
        var cities = new List<City>
        {
            new City { Name = "Montreal" },
            new City { Name = " Quebec" },
            new City { Name = "Brossard" },
            new City { Name = "Chicoutimi" }
        };

        return Task.FromResult(cities);
    }
}