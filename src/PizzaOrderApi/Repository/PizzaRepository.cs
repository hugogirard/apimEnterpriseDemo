namespace PizzaOrderApi.Repository;

public class PizzaRepository : IPizzaRepository
{
    private readonly Dictionary<string, Pizza> _pizzas;

    public PizzaRepository()
    {
        _pizzas = new Dictionary<string, Pizza>();
        InitializePizzas();
    }
    
    private void InitializePizzas()
    {
        // Add pizzas to the dictionary
        _pizzas.Add("Margherita", new Pizza("Margherita", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Basil", Category.Veggie, 1.99), Quantity.Normal)
        }));

        _pizzas.Add("Pepperoni", new Pizza("Pepperoni", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Pepperoni", Category.Meat, 4.99), Quantity.Normal)
        }));

        _pizzas.Add("Hawaiian", new Pizza("Hawaiian", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Ham", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Pineapple", Category.Veggie, 1.99), Quantity.Normal)
        }));

        _pizzas.Add("BBQ Chicken", new Pizza("BBQ Chicken", new List<Ingredient>
        {
            new Ingredient(new IngredientType("BBQ Sauce", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Chicken", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Onion", Category.Veggie, 1.99), Quantity.Normal)
        }));

        _pizzas.Add("Supreme", new Pizza("Supreme", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Pepperoni", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mushroom", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Onion", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Bell Pepper", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Olives", Category.Veggie, 1.99), Quantity.Normal)
        }));

        _pizzas.Add("Meat Lovers", new Pizza("Meat Lovers", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Pepperoni", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Sausage", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Bacon", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Ham", Category.Meat, 4.99), Quantity.Normal)
        }));

        _pizzas.Add("Veggie Delight", new Pizza("Veggie Delight", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Mushroom", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Onion", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Bell Pepper", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Olives", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Spinach", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Tomato", Category.Veggie, 1.99), Quantity.Normal)
        }));

        _pizzas.Add("Four Cheese", new Pizza("Four Cheese", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Cheddar", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Parmesan", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Gorgonzola", Category.Cheese, 3.49), Quantity.Normal)
        }));

        _pizzas.Add("Buffalo Chicken", new Pizza("Buffalo Chicken", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Buffalo Sauce", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Chicken", Category.Meat, 4.99), Quantity.Normal),
            new Ingredient(new IngredientType("Onion", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Blue Cheese", Category.Cheese, 3.49), Quantity.Normal)
        }));

        _pizzas.Add("Mediterranean", new Pizza("Mediterranean", new List<Ingredient>
        {
            new Ingredient(new IngredientType("Tomato", Category.Sauce, 2.99), Quantity.Normal),
            new Ingredient(new IngredientType("Mozzarella", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Feta", Category.Cheese, 3.49), Quantity.Normal),
            new Ingredient(new IngredientType("Olives", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Onion", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Bell Pepper", Category.Veggie, 1.99), Quantity.Normal),
            new Ingredient(new IngredientType("Tomato", Category.Veggie, 1.99), Quantity.Normal)
        }));
    }
    
    public async Task<Dictionary<string, double>> GetAllPizzas()
    {
        Dictionary<string, double> pizzaNamesWithPrice = new Dictionary<string, double>();

        foreach (var pizza in _pizzas)
        {
            pizzaNamesWithPrice.Add(pizza.Key, pizza.Value.Price);
        }

        return await Task.FromResult(pizzaNamesWithPrice);
    }
    
    public async Task<Pizza> GetPizzaByName(string name)
    {
        if (_pizzas.ContainsKey(name))
        {
            return await Task.FromResult(_pizzas[name]);
        }

        return await Task.FromResult<Pizza>(null);
    }
}