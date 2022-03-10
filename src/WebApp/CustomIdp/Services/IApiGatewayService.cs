
namespace CustomIdp.Services
{
    public interface IApiGatewayService
    {
        Task CreateUserAsync(string email, string firstname, string lastname, string userId);
        Task<string> GetRedirectionUrlAsync(string userId);
        bool ValidateSignature(string sig, string operations, string salt, string returnUrl);
    }
}