param location string
param suffix string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'log-${suffix}'
  location: location  
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appinsigh-${suffix}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

output appInsightName string = appInsights.name
