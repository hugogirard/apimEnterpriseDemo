param apimName string
param apiServiceUrl string
param repobaseUrl string

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
    repobaseUrl: repobaseUrl
  }
}

module apisProduct 'modules/apim/products/productApi.bicep' = {
  name: 'apisProduct'
  params: {
    apimName: apimName
    apiName: weatherApi.outputs.name
    productName: weatherProduct.outputs.productName
  }
}
