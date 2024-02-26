param location string

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'gateway-identity'
  location: location
}


output userIdentityId string = identity.id 
