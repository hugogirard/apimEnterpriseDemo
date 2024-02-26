resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: 'vnet-spoke-prod'    
}

output subnetIdOne string = vnet.properties.subnets[0].id

