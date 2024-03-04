using System.Reflection;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IPizzaRepository,PizzaRepository>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

int callRequest = 0;

app.UseHttpsRedirection();

app.MapGet("/pizzas", async (IPizzaRepository pizzaRepository) =>
{
    var random = new Random();
    var delay = random.Next(1, 5001);
    await Task.Delay(delay);

    var pizzas = await pizzaRepository.GetAllPizzas();
    return Results.Ok(pizzas.Select(p => new PizzasViewModel(p.Key, p.Value)));
})
.WithName("GetAllPizzas")
.Produces<IEnumerable<PizzasViewModel>>()
.WithOpenApi();

app.MapGet("/pizzas/{name}", async (IPizzaRepository pizzaRepository, string name) =>
{
    callRequest++;

    if (callRequest % 20 == 0)
    {           
        return Results.StatusCode(500);
    }

    var pizza = await pizzaRepository.GetPizzaByName(name);
    if (pizza == null)
    {        
        return Results.NotFound($"Pizza with name {name} not found.");
    }

    return Results.Ok(new PizzaViewModel(pizza.Name, 
                                         pizza.Ingredients.Select(i => new IngredientViewModel(i.Type.Name, i.Type.Price))));
    // return Results.Ok(new 
    // { 
    //     pizza.Name,
    //     Ingredients = pizza.Ingredients.Select(i => new 
    //     {
    //         i.Type.Name,
    //         i.Type.Price

    //     }).ToList()
    // });    
})
.WithName("GetPizzaByName")
.Produces<PizzaViewModel>()
.WithOpenApi();

app.Run();
