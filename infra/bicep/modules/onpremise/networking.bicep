param location string
param vnetConfiguration object

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'nsg-onpremise'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetConfiguration.name
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
            id: nsg.id
          }          
        }
      }
      {
        name: vnetConfiguration.subnets[1].name
        properties: {
          addressPrefix: vnetConfiguration.subnets[1].addressPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
      {
        name: vnetConfiguration.subnets[2].name
        properties: {
          addressPrefix: vnetConfiguration.subnets[2].addressPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }              
    ]
  }
}
