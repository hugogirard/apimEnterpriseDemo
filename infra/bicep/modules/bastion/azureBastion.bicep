param suffix string
param location string
param subnetId string

resource pipBastion 'Microsoft.Network/publicIPAddresses@2020-07-01' = {
  name: 'pip-bastion-${suffix}'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }  
}

resource bastion 'Microsoft.Network/bastionHosts@2020-07-01' = {
  name: 'bastion-${suffix}'
  location: location 
  properties: {
    ipConfigurations: [
      {
        name: 'bastionipcfg-${suffix}'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pipBastion.id             
          }
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
} 
