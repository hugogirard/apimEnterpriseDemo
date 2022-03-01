param location string
param suffix string

resource appservice 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'app-${suffix}'
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

output appServiceId string = appservice.id
