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
  properties: {
    description: 'Administrators is a built-in group. Its membership is managed by the system. Microsoft Azure subscription administrators fall into this group.'
    displayName: 'Administrators'
    type: 'system'
    builtIn: true
  }
  name: 'administrators'
}
