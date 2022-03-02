param apimName string

module weatherProduct 'modules/apim/products/weather.bicep' = {
  name: 'weatherProduct'
  params: {
    apimName: apimName
  }
}
