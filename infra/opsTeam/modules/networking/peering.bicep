param parentVnetName string
param remoteVnetId string
param peeringName string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: parentVnetName
}

resource connectionHubToSpoke 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-04-01' = {
  parent:vnet
  name: peeringName  
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: remoteVnetId
    }
  }
}
