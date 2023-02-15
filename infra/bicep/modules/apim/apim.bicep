param location string
param name string
param tags object
param publisherName string
param publisherEmail string

resource apim 'Microsoft.ApiManagement/service@2022-04-01-preview' = {
  name: name
  location: location
  properties: {
      publisherEmail: publisherEmail
      publisherName: publisherName
  }
  identity: {
      type: 'SystemAssigned'
  }
  tags: tags
  sku: {
      name: 'Developer'
      capacity: 1
  }
}

output apimName string = apim.name
