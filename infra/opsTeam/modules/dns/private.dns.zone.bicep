param location string
param dnsZoneName string
param vnetId string

resource dns 'Microsoft.Network/privateDnsZones@2018-09-01' = {
    name: dnsZoneName
    location: 'global'
    properties: {
    }
}


resource privateDnsZone 'Microsoft.Network/privateDnsZones@2021-05-01' = {
  name: dnsZoneName
  location: location
}

resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2021-05-01' = {
  name: 'vnetLink'
  parent: privateDnsZone
  properties: {
    virtualNetwork: {
      id: vnetId
    }
  }
}
