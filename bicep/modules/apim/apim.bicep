param location string
param suffix string
param publisherEmail string
param publisherName string

resource apim 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: 'apim-${suffix}'
  location: location
  sku: {
    capacity: 1
    name: 'Developer'
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

output apimName string = apim.name
