public interface IPizzaRepository
{
    Task<Dictionary<string, double>> GetAllPizzas();
    Task<Pizza> GetPizzaByName(string name);
}
