param name string
param location string

resource pip 'Microsoft.Network/publicIPAddresses@2020-07-01' = {
  name: name
  location: location
  zones: [
    '1'
    '2'
    '3'
  ]
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'    
  }
}

output publicIp string = pip.id
