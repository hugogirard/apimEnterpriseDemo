param location string
param dnsZoneName string
param vnetId string

resource dns 'Microsoft.Network/privateDnsZones@2020-06-01' = {
    name: dnsZoneName
    location: 'global'
    properties: {
    }
}

resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: 'vnetLink'
  parent: dns
  properties: {
    virtualNetwork: {
      id: vnetId
    }
  }
}
