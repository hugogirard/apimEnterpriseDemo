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

resource networkRuleCollections 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-06-01' = {
  parent: firewallPolicies
  name: 'DefaultNetworkRuleCollectionGroup'
  properties: {
    priority: 200
    ruleCollections: [
      {
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        action: {
          type: 'Allow'
        }
        rules: [
          {
            ruleType: 'NetworkRule'
            name: 'ApimToMonitor'
            ipProtocols: [
              'TCP'
            ]
            sourceAddresses: [
              '10.1.2.0/24'
            ]
            sourceIpGroups: []
            destinationAddresses: [
              'AzureMonitor'
            ]
            destinationIpGroups: []
            destinationFqdns: []
            destinationPorts: [
              '443'
              '1886'
            ]
          }
          {
            ruleType: 'NetworkRule'
            name: 'ApimToAzureAD'
            ipProtocols: [
              'TCP'
            ]
            sourceAddresses: [
              '10.1.2.0/24'
            ]
            sourceIpGroups: []
            destinationAddresses: [
              'AzureActiveDirectory'
            ]
            destinationIpGroups: []
            destinationFqdns: []
            destinationPorts: [
              '443'
            ]
          }
          {
            ruleType: 'NetworkRule'
            name: 'SiteRecovery'
            ipProtocols: [
              'TCP'
            ]
            sourceAddresses: [
              '10.1.2.0/24'
            ]
            sourceIpGroups: []
            destinationAddresses: [
              'AzureSiteRecovery'
            ]
            destinationIpGroups: []
            destinationFqdns: []
            destinationPorts: [
              '443'
            ]
          }
        ]
        name: 'DefaultNetworkRule'
        priority: 100
      }
    ]
  }
}

output privateIp string = firewall.properties.ipConfigurations[0].properties.privateIPAddress
