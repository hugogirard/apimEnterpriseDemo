param location string
param suffix string
param appServicePlanId string

resource webapp 'Microsoft.Web/sites@2021-03-01' = {
  name: 'weather-api-${suffix}'
  location: location
  properties: {
    serverFarmId: appServicePlanId
    clientAffinityEnabled: false
    siteConfig: {
      netFrameworkVersion: 'v6.0'
      phpVersion: 'OFF'
      alwaysOn: true
    }
  }
}

output webappName string = webapp.name
