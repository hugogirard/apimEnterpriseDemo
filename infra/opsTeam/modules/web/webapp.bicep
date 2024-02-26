param location string
param appInsightsName string
param redisCacheName string
param suffix string

resource redisCache 'Microsoft.Cache/redis@2023-08-01' existing = {
  name: redisCacheName
}

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' existing = {
  name: appInsightsName
}

resource asp 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-ordersrv-${suffix}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
  }
}

resource web 'Microsoft.Web/sites@2023-01-01' = {
  name: 'web-ordersrv-${suffix}'
  location: location
  properties: {
    serverFarmId: asp.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~2'
        }            
        {
          name: 'RedisCnxString'
          value: '${redisCache.name}.redis.cache.windows.net:6380,password=${redisCache.listKeys().primaryKey},ssl=True,abortConnect=False'          
        }
      ]
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
      netFrameworkVersion: 'v8.0'
      alwaysOn: true
    }
  }  
}

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: web
  name: 'web'
  properties: {
    repoUrl: 'https://github.com/hugogirard/shippingCompany'
    branch: 'main'
    isManualIntegration: true
  }
}

output appName string = web.name
