targetScope='subscription'

param location string
param rgName string

resource appRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

var suffix = uniqueString(appRg.id)

module monitoring 'modules/monitoring/monitoring.bicep' = {
  scope: resourceGroup(appRg.name)
  name: 'monitoring'
  params: {
    location: location
    suffix: suffix
  }
}

module cache 'modules/cache/redis.bicep' = {
  scope: resourceGroup(appRg.name)
  name: 'cache'
  params: {
    location: location
    suffix: suffix
  }
}

module webapp 'modules/web/webapp.bicep' = {
  scope: resourceGroup(appRg.name)
  name: 'webApp'
  params: {
    appInsightsName: monitoring.outputs.appInsightName
    location: location
    redisCacheName: cache.outputs.redisCacheName
    suffix: suffix
  }
}

output webAppName string = webapp.outputs.appName
