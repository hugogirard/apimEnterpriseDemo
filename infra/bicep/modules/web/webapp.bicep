param location string
param webappname string
param aspName string
param appInsightsName string

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' existing = {
  name: appInsightsName
}

resource asp 'Microsoft.Web/serverfarms@2020-06-01' existing = {
  name: aspName
}

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webappname
  location: location  
  properties: {
    serverFarmId: asp.id    
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
      ]
      vnetRouteAllEnabled: true
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
      netFrameworkVersion: 'v7.0'
      alwaysOn: true      
    }    
    clientAffinityEnabled: false
    httpsOnly: true          
  }  
}

output appName string = webApp.name
