param ApimServiceName string
param apiServiceUrl string

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

resource ApimServiceName_weather_api_621e8894463461025c0b354f 'Microsoft.ApiManagement/service/apis/schemas@2021-01-01-preview' = {
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
  name: '621e8894463461025c0b354f'
}

resource ApimServiceName_weather_api_get_api_getforecastcities 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  parent: ApimServiceName_weather_api
  dependsOn: [
    ApimServiceName_weather_api_621e8894463461025c0b354f
  ]
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
            sample: '[\r\n  {\r\n    "id": "583eb25b-d975-46e5-bdb9-4a8c8ad225ed",\r\n    "name": "Boston"\r\n  },\r\n  {\r\n    "id": "8ceb628f-bd24-4cba-8bcd-6b5dc0048899",\r\n    "name": "NYC"\r\n  }\r\n]'
            schemaId: '621e8894463461025c0b354f'
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
}

output name string = apiName
