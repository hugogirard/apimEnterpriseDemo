

public record PizzaViewModel(string name, IEnumerable<IngredientViewModel> ingredients);

public record IngredientViewModel(string name, double price);