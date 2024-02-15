param location string

var vnetHubConfiguration = {
  name: 'vnet-hub'
  addressPrefixe: '10.0.0.0/16'
  subnets: [
    {
      name: 'AzureFirewallSubnet'
      addressPrefix: '10.0.1.0/24'
    }
    {
      name: 'AzureFirewallManagementSubnet'
      addressPrefix: '10.0.2.0/24'
    }
  ]
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetHubConfiguration.name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetHubConfiguration.addressPrefixe
      ]
    }
    subnets: [
      {
        name: vnetHubConfiguration.subnets[0].name // Azure Firewall 
        properties: {
          addressPrefix: vnetHubConfiguration.subnets[0].addressPrefix
        }
      }        
      {
        name: vnetHubConfiguration.subnets[1].name // Azure Firewall 
        properties: {
          addressPrefix: vnetHubConfiguration.subnets[1].addressPrefix
        }
      }              
    ]
  }
}

output vnetName string = vnet.name
output vnetId string = vnet.id
output subnets array = vnet.properties.subnets
