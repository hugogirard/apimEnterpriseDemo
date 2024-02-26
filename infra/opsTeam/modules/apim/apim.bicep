param location string
param name string
param tags object
param publisherName string
param publisherEmail string
param pipId string
param apimSubnetId string

resource apim 'Microsoft.ApiManagement/service@2022-04-01-preview' = {
  name: name
  location: location
  properties: {
      virtualNetworkType: 'Internal'
      publisherEmail: publisherEmail
      publisherName: publisherName
      publicIpAddressId: pipId
      virtualNetworkConfiguration: {
        subnetResourceId: apimSubnetId        
      }      
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
output apimMsi string = apim.identity.principalId
