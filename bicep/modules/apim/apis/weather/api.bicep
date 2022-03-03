param ApimServiceName string
param apiServiceUrl string

resource ApimServiceName_weather_api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  properties: {
    description: 'Weather API'
    subscriptionKeyParameterNames: {
      header: 'Ocp-Apim-Subscription-Key'
      query: 'subscription-key'
    }
    apiRevision: '1'
    isCurrent: true
    subscriptionRequired: true
    displayName: 'Weather API'
    serviceUrl: apiServiceUrl
    format: 'openapi-link' // If using V3 spec use openapi-link otherwise swagger-link-json  
    value: '${apiServiceUrl}swagger/v1/swagger.json'
    path: 'wth'
    protocols: [
      'https'
    ]
  }
  name: '${ApimServiceName}/weather-api'
  dependsOn: []
}
