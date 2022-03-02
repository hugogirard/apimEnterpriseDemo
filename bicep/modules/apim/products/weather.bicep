param apimName string

resource weatherProduct 'Microsoft.ApiManagement/service/products@2021-01-01-preview' = {
  properties: {
    description: 'Provide all APIs for the weather'
    subscriptionRequired: true
    approvalRequired: true
    subscriptionsLimit: 1
    state: 'published'
    displayName: 'WeatherForecast'
  }
  name: '${apimName}/weatherforecast'
}

resource adminGroup 'Microsoft.ApiManagement/service/products/groups@2021-01-01-preview' = {
  parent: weatherProduct
  name: 'administrators'
}
