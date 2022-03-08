
namespace CustomIdp.Services
{
    public interface IApiGatewayService
    {
        Task CreateUserAsync(string email,string firstname, string lastname, string userId);
    }
}