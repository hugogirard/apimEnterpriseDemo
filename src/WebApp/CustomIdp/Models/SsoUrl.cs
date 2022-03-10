using Newtonsoft.Json;

namespace CustomIdp.Models;

public class SsoUrl
{
    [JsonProperty("value")]
    public string Value { get; set; }
}
