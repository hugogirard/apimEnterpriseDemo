param dnsZoneName string
param vnetId string

resource dns 'Microsoft.Network/privateDnsZones@2020-06-01' = {
    name: dnsZoneName
    location: 'global'
    properties: {
    }
}

resource soa 'Microsoft.Network/privateDnsZones/SOA@2020-06-01' = {
  name: '@'
  parent: dns
  properties: {}
}

resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: 'vnetLink'
  location: 'global'
  parent: dns
  properties: {
    virtualNetwork: {
      id: vnetId
    }
  }
}
