namespace Contoso;

public class Seeder
{
    public void Seed()
    {
        Faker.Company.Name();    
        Faker.Address.StreetAddress();
        Faker.Address.StreetName();
        Faker.Name.FullName();        
    }
}