param location string
param fwPrivateIP string
param fwPublicIP string

resource aseRouteTable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: 'rt-apim'
  location: location
  properties: {    
    routes: [
      {
        name: 'apim-to-fw'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: fwPrivateIP
        }
      }
    ]
  }
}

output routeTableId string = aseRouteTable.id
