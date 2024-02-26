param dnsZoneName string
param vnetId string

resource dns 'Microsoft.Network/privateDnsZones@2020-06-01' = {
    name: dnsZoneName
    location: 'global'
}

resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: uniqueString(vnetId)
  location: 'global'
  parent: dns
  properties: {
    virtualNetwork: {
      id: vnetId
    }
    registrationEnabled: false
  }
}
