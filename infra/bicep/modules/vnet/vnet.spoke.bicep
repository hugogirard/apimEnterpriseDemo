param location string
param name string
param vnetConfiguration object
param nsgId string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetConfiguration.addressPrefixe
      ]
    }
    subnets: [
      {
        name: vnetConfiguration.subnets[0].name
        properties: {
          addressPrefix: vnetConfiguration.subnets[0].addressPrefix
          networkSecurityGroup: {
            id: nsgId
          }
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output vnetName string = vnet.name
