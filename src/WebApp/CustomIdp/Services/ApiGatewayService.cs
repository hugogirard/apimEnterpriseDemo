using CustomIdp.Models;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Net.Http.Headers;
using static System.Net.Mime.MediaTypeNames;
using Newtonsoft.Json;

namespace CustomIdp.Services;

public class ApiGatewayService : IApiGatewayService
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly IConfiguration _configuration;
    private readonly string BASE_URL;
    private readonly string API_VERSION = "2021-08-01";

    public ApiGatewayService(IHttpClientFactory httpClientFactory, IConfiguration configuration)
    {
        _httpClientFactory = httpClientFactory;
        _configuration = configuration;

        BASE_URL = $"https://{configuration["Apim:Name"]}.management.azure-api.net/subscriptions/{configuration["Apim:Subscription"]}/resourceGroups/{configuration["Apim:ResourceGroup"]}/providers/Microsoft.ApiManagement/service/{configuration["Apim:Name"]}";

    }

    public async Task CreateUserAsync(string email, string firstname, string lastname, string userId)
    {        
        string sasToken = CreateSasToken(DateTime.UtcNow.AddMinutes(15));
        var http = _httpClientFactory.CreateClient();
        
        var user = new ApimUser(email,firstname, lastname, userId);

        var userJson = new StringContent(JsonConvert.SerializeObject(user),
                                             Encoding.UTF8,
                                             Application.Json);

        http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("SharedAccessSignature", sasToken);
        string url = $"{BASE_URL}/users/{userId}?api-version=${API_VERSION}";        


        using var httpResponseMessage = await http.PutAsync(url, userJson);

        if (httpResponseMessage.IsSuccessStatusCode) 
        {
            string responseBody = await httpResponseMessage.Content.ReadAsStringAsync();
        }
    }


    private string CreateSasToken(DateTime expiry) 
    {
        var id = _configuration["Apim:Identifier"];
        var key = _configuration["Apim:Key"];
        using (var encoder = new HMACSHA512(Encoding.UTF8.GetBytes(key)))
        {
            string dataToSign = id + "\n" + expiry.ToString("O", CultureInfo.InvariantCulture);
            string x = string.Format("{0}\n{1}", id, expiry.ToString("O", CultureInfo.InvariantCulture));
            var hash = encoder.ComputeHash(Encoding.UTF8.GetBytes(dataToSign));
            var signature = Convert.ToBase64String(hash);
            string encodedToken = string.Format("uid={0}&ex={1:o}&sn={2}", id, expiry, signature);
            return encodedToken;
        }
    }
    
    private async Task GetBearerTokenAsync()
    {
        string url = $"https://login.microsoftonline.com/{_configuration["AzureAD:TenantId"]}/oauth2/token";

        var payload = new[]
        {
            new KeyValuePair<string,string>("grant_type", "client_credentials"),
            new KeyValuePair<string, string>("client_id", _configuration["ServicePrincipal:clientId"]),
            new KeyValuePair<string, string>("client_secret", _configuration["ServicePrincipal:secret"]),
            new KeyValuePair<string, string>("resource", "https://management.azure.com/")
        };

        var http = _httpClientFactory.CreateClient();

        var result = await http.PostAsync(url, new FormUrlEncodedContent(payload));
    }
}
