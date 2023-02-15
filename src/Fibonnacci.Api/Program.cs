var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(o => 
{
    o.SwaggerEndpoint("/swagger/v1/swagger.yaml", "Fibonacci API");
    o.RoutePrefix = string.Empty;    
});

app.UseHttpsRedirection();

app.MapGet("/api/fibonacci/{len}", (int len) =>
{
    var sequence = new List<int>();

    int firstNumber = 0, SecondNumber = 1, nextNumber;

    if(len < 2)
    {
        return sequence;
    }
    else
    {        
        for(int i = 2; i < len; i++)
        {
            nextNumber = firstNumber + SecondNumber;
            sequence.Add(nextNumber);
            firstNumber = SecondNumber;
            SecondNumber = nextNumber;
        }

        return sequence;
    }

})
.WithName("Get Fibonacci sequence")
.WithOpenApi();


app.Run();