namespace PizzaOrderApi.Model;

public record Pizza(string Name, List<Ingredient> Ingredients)
{
    public double Price => Math.Floor(Ingredients.Sum(ingredient => ingredient.Type.Price));
}

public enum Quantity
{
    Normal,
    Half,
    Double,
    Triple
}

public record Ingredient(IngredientType Type, Quantity Quantity);

public record IngredientType(string Name, Category Category, double Price);

public enum Category
{
    Meat,
    Veggie,
    Cheese,
    Sauce,
    Fruit,
    Herb,
    Seafood
}

