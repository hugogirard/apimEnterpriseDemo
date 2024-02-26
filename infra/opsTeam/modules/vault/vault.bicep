param suffix string
param location string = 'eastus'
param apimIdentity string

// Key Vault Reader
var roleDefinitionId = '21090545-7ca7-4776-b22c-e363652d74d2'

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


resource rbacSecretReader 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: 'rbacSecretReader'
  scope: keyVault
  properties: {
    principalId: apimIdentity
    roleDefinitionId: roleDefinitionId
    principalType: 'ServicePrincipal'
  }
}
