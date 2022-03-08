param ApimServiceName string

resource ApimServiceName_weather_api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  properties: {
    description: 'Weather API'
    authenticationSettings: {
      subscriptionKeyRequired: false
    }
    subscriptionKeyParameterNames: {
      header: 'Ocp-Apim-Subscription-Key'
      query: 'subscription-key'
    }
    apiRevision: '1'
    isCurrent: true
    subscriptionRequired: true
    displayName: 'Weather API'
    serviceUrl: 'https://weather-api-yex6d5nrl7nuk.azurewebsites.net/'
    path: 'wth'
    protocols: [
      'https'
    ]
  }
  name: '${ApimServiceName}/weather-api'
  dependsOn: []
}

resource ApimServiceName_weather_api_6220f26c463461025c0b35c8 'Microsoft.ApiManagement/service/apis/schemas@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api
  properties: {
    contentType: 'application/vnd.oai.openapi.components+json'
    document: {
      components: {
        schemas: {
          City: {
            type: 'object'
            properties: {
              id: {
                type: 'string'
                nullable: true
              }
              name: {
                type: 'string'
                nullable: true
              }
            }
            additionalProperties: false
          }
          ApiGetForecastCitiesGet200ApplicationJsonResponse: {
            type: 'array'
            items: {
              '$ref': '#/components/schemas/City'
            }
            'x-apim-inline': true
          }
        }
      }
    }
  }
  name: '6220f26c463461025c0b35c8'
}

resource ApimServiceName_weather_api_get_api_getforecastcities 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api
  properties: {
    templateParameters: []
    request: {
      queryParameters: []
      headers: []
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'Success'
        headers: []
        representations: [
          {
            contentType: 'application/json'
            sample: '[\r\n  {\r\n    "id": "string",\r\n    "name": "string"\r\n  }\r\n]'
            schemaId: '6220f26c463461025c0b35c8'
            typeName: 'ApiGetForecastCitiesGet200ApplicationJsonResponse'
          }
        ]
      }
    ]
    displayName: '/api/getForecastCities - GET'
    method: 'GET'
    urlTemplate: '/api/getForecastCities'
  }
  name: 'get-api-getforecastcities'
  dependsOn: [
    ApimServiceName_weather_api_6220f26c463461025c0b35c8
  ]
}

resource ApimServiceName_weather_api_get_api_getforecastcities_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api_get_api_getforecastcities
  properties: {
    value: '<!--\n    IMPORTANT:\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\n    - To remove a policy, delete the corresponding policy statement from the policy document.\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\n    - Policies are applied in the order of their appearance, from the top down.\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\n-->\r\n<policies>\r\n\t<inbound>\r\n\t\t<base />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t</outbound>\r\n\t<on-error>\r\n\t\t<base />\r\n\t</on-error>\r\n</policies>'
    format: 'rawxml'
  }
  name: 'policy'
}

resource ApimServiceName_weather_api_get_api_getforecastcities_WeatherApi 'Microsoft.ApiManagement/service/apis/operations/tags@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api_get_api_getforecastcities
  properties: {
    displayName: 'WeatherApi'
  }
  name: 'WeatherApi'
}

resource ApimServiceName_weather_api_policy 'Microsoft.ApiManagement/service/apis/policies@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api
  properties: {
    value: '<policies>\r\n\t<inbound>\r\n\t\t<base />\r\n\t\t<rate-limit-by-key calls="10" renewal-period="60" counter-key="@(context.Subscription?.Key ?? "anonymous")" />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t</outbound>\r\n\t<on-error>\r\n\t\t<base />\r\n\t</on-error>\r\n</policies>'
    format: 'rawxml'
  }
  name: 'policy'
}

resource ApimServiceName_weatherforecast_weather_api 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
  name: '${ApimServiceName}/weatherforecast/weather-api'
  dependsOn: [
    ApimServiceName_weather_api
  ]
}