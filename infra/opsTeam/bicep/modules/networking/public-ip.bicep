param name string
param location string

resource pip 'Microsoft.Network/publicIPAddresses@2020-07-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }  
  properties: {
    publicIPAllocationMethod: 'Static'    
    dnsSettings: {
      domainNameLabel: name
    }
  }
}

output publicIp string = pip.id
