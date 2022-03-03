param apimName string
param productName string
param apiName string

resource apisWeather 'Microsoft.ApiManagement/service/products/apis@2021-08-01' = {
  name: '${apimName}/${productName}/${apiName}'
}
