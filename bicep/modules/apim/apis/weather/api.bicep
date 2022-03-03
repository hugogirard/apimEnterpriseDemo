param ApimServiceName string
param apiServiceUrl string
param repobaseUrl string

var apiName = 'weather-api'

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
  name: '${ApimServiceName}/${apiName}'
  dependsOn: []
}

resource apiPolicy 'Microsoft.ApiManagement/service/apis/policies@2021-08-01' = {
  name: '${ApimServiceName}/${apiName}/policy'
  dependsOn: [
    ApimServiceName_weather_api
  ]
  properties: {
    value: '${repobaseUrl}/bicep/modules/apim/apis/weather/policy.xml'
    format: 'rawxml-link'
  }
}


output name string = apiName
