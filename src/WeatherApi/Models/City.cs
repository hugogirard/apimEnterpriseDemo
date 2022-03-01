namespace WeatherApi.Models;

public class City 
{
    public string Id { get; set; }

    public string Name { get; set; }

    public City()
    {
        Id = Guid.NewGuid().ToString();
    }
}