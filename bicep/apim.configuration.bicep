param apimName string
param apiServiceUrl string

module weatherProduct 'modules/apim/products/weather.bicep' = {
  name: 'weatherProduct'
  params: {
    apimName: apimName
  }
}

module weatherApi 'modules/apim/apis/weather/api.bicep' = {
  name: 'weatherapi'
  params: {
    ApimServiceName: apimName
    apiServiceUrl: apiServiceUrl
  }
}
