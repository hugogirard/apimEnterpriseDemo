targetScope='subscription'

@description('The location where the resources will be deployed')
param location string

@description('The Publisher name of APIM')
@secure()
param publisherName string

@description('The email of the APIM admin')
@secure()
param publisherEmail string

param dnsZoneName string

// Create resource group
var suffixProd = uniqueString(prodSpoke.id)
var suffixHub = uniqueString(hub.id)

var hubResourceGroup = 'rg-hub'
var spokeProdResourceGroupName = 'rg-apim-prod-spoke'

resource hub 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: hubResourceGroup
  location: location
}

resource prodSpoke 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: spokeProdResourceGroupName
  location: location
}

// End create resource group

// Create Vault
module keyVault 'modules/vault/vault.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'keyVault'
  params: {
    suffix: suffixProd
    location: location
  }
}

// Create the hub
module vnetHub 'modules/networking/vnet.hub.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'hub-vnet'
  params: {
    location: location    
  }
}

// End create hub

// Create Azure Firewall

module pipfw 'modules/networking/public-ip.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'pipfw'
  params: {
    location: location
    name: 'pip-fw-${suffixProd}'
  }
}

module pipfwmanagement 'modules/networking/public-ip.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'pipfwmanagement'
  params: {
    location: location
    name: 'pip-fw-management-${suffixProd}'
  }
}

module firewall 'modules/firewall/azureFirewall.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'firewall'
  params: {
    location: location
    pipFwId: pipfw.outputs.publicId
    pipFwManagementId: pipfwmanagement.outputs.publicId    
    suffix: suffixHub
    subnetFwId: vnetHub.outputs.subnets[0].id
    subnetManagemenentId: vnetHub.outputs.subnets[1].id
  }
}

// end firewall

module routeTable 'modules/networking/routeTable.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'routeTable'
  params: {
    fwPrivateIP: firewall.outputs.privateIp
    location: location
  }
}

// Create shared prod spoke
module vnetSpokeShared 'modules/networking/vnet.shared.spoke.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'vnet-spoke-shared'
  params: {    
    location: location   
    routeTableId: routeTable.outputs.routeTableId
  }
}

module pipProdApim 'modules/networking/public-ip.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'pipProdApim'
  params: {
    location: location
    name: 'pip-prod-apim-${suffixProd}'
  }
}

module apimProd 'modules/apim/apim.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'apim-prod'
  params: {
    location: location
    name: 'apim-prod-${suffixProd}'
    publisherEmail: publisherEmail
    publisherName: publisherName
    apimSubnetId: vnetSpokeShared.outputs.subnetIdOne
    pipId: pipProdApim.outputs.publicId
    tags: {
      environment: 'prod'
    }
  }
}
// End create prod spoke

// Peering

module hubToSpoke 'modules/networking/peering.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'hubToSpoke'
  dependsOn: [
    vnetHub
    vnetSpokeShared
  ]
  params: {
    parentVnetName: vnetHub.outputs.vnetName
    peeringName: 'hubToSpoke'
    remoteVnetId: vnetSpokeShared.outputs.vnetId
  }
}

module spokeToHub 'modules/networking/peering.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'spokeToHub'
  dependsOn: [
    vnetHub
    vnetSpokeShared
  ]
  params: {
    parentVnetName: vnetSpokeShared.outputs.vnetName
    peeringName: 'spokeToHub'
    remoteVnetId: vnetHub.outputs.vnetId
  }
}

// Private DNS Zone
module apimPrivateDNS 'modules/dns/private.dns.zone.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'apimPrivateDNS'
  params: {
    dnsZoneName: dnsZoneName
    location: location
    vnetId: vnetSpokeShared.outputs.vnetId
  }
}

output apimProdName string = apimProd.outputs.apimName
