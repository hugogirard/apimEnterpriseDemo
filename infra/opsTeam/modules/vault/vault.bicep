param suffix string
param location string = 'eastus'

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: 'vault-${suffix}'
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    accessPolicies: [
    ]
  }
}
