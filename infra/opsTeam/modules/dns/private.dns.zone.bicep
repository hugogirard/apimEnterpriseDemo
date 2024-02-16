param location string
param dnsZoneName string
param vnetId string
param developerPortalFqdn string
param gatewayFqdn string
param managementPortalFqdn string


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

resource developerPortalRecord 'Microsoft.Network/privateDnsZones/A@2021-05-01' = {
  name: 'developer'
  parent: privateDnsZone
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: developerPortalFqdn
      }
    ]
  }
}

resource gatewayRecord 'Microsoft.Network/privateDnsZones/A@2021-05-01' = {
  name: 'gateway'
  parent: privateDnsZone
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: gatewayFqdn
      }
    ]
  }
}

resource managementPortalRecord 'Microsoft.Network/privateDnsZones/A@2021-05-01' = {
  name: 'management'
  parent: privateDnsZone
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: managementPortalFqdn
      }
    ]
  }
}
