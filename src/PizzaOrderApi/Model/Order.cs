namespace PizzaOrderApi.Model;

public record Address
{
    public string Street { get; init; }
    public string CivicNumber { get; init; }
    public string City { get; init; }
    public string PostalCode { get; init; }
}

public record Order
{
    public List<Pizza> Pizzas { get; init; }
    public string CustomerName { get; init; }
    public Address Address { get; init; }
    public double Cost => Pizzas.Sum(pizza => pizza.Price);

    public string PhoneNumber { get; set; }
}