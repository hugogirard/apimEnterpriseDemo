param location string
param suffix string

resource serverFarm 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'asp-${suffix}'
  location: location
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
    size: 'P1v2'
    family: 'P1v2'
    capacity: 1
  }
  kind: 'app'
}

output aspName string = serverFarm.name
