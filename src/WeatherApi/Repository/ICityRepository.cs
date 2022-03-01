namespace WeatherApi.Repository;

public interface ICityRepository
{
    Task<List<City>> AllAsync();
}
