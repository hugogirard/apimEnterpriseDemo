param location string
param suffix string
param subnetFwId string
param subnetManagemenentId string
param pipFwId string
param pipFwManagementId string


resource firewallPolicies 'Microsoft.Network/firewallPolicies@2021-05-01' = {
  name: 'fw-policy-${suffix}'
  location: location
  properties: {
    sku: {
      tier: 'Basic'
    }
    threatIntelMode: 'Alert'
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2021-05-01' = {
  name: 'fw-${suffix}'
  location: location
  zones: []
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: subnetFwId
          }
          publicIPAddress: {
            id: pipFwId
          }
        }
      }
    ]
    sku: {
      tier: 'Basic'
    }
    managementIpConfiguration: {
      name: 'managementIpConfig'
      properties: {
        subnet: {
          id: subnetManagemenentId
        }
        publicIPAddress: {
          id: pipFwManagementId
        }      
      }
    }
    firewallPolicy: {
      id: firewallPolicies.id
    }
  }
}

output privateIp string = firewall.properties.ipConfigurations[0].properties.privateIPAddress
