using Newtonsoft.Json;

namespace CustomIdp.Models
{
    public class DeveloperPortalTokenPayload
    {
        [JsonProperty("properties")]
        public DeveloperPortalTokenProperties DeveloperPortalTokenProperties { get; set; }

        public DeveloperPortalTokenPayload()
        {
            DeveloperPortalTokenProperties = new DeveloperPortalTokenProperties();
        }
    }

    public class DeveloperPortalTokenProperties 
    {
        [JsonProperty("expiry")]
        public string Expiry { get; set; }

        [JsonProperty("keyType")]
        public string KeyType => "primary";
    }
}
