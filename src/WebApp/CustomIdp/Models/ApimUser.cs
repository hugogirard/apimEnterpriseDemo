using Newtonsoft.Json;

namespace CustomIdp.Models;

public class ApimUser
{
    public ApimUser(string email, string firstname, string lastname, string userId)
    {
        Properties = new UserProperties 
        { 
            Firstname = firstname,
            Lastname = lastname,
            Email = email
        };
    }

    [JsonProperty("properties")]
    public UserProperties Properties { get; set; }
}

public class UserProperties 
{
    [JsonProperty("firstName")]
    public string Firstname { get; set; }

    [JsonProperty("lastName")]
    public string Lastname { get; set; }

    [JsonProperty("email")]
    public string Email { get; set; }
}
