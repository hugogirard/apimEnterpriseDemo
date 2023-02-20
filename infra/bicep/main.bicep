targetScope='subscription'

@description('The location where the resources will be deployed')
param location string

@description('The Publisher name of APIM')
@secure()
param publisherName string

@description('The email of the APIM admin')
@secure()
param publisherEmail string

// var vnetSpokeDevConfiguration = {
//   name: 'vnet-spoke-dev'
//   addressPrefixe: '11.0.0.0/16'
//   subnets: [
//     {
//       name: 'subnet-apim-dev'
//       addressPrefix: '11.0.1.0/24'
//     }
//   ]
// }

var vnetSpokeProdConfiguration = {
  name: 'vnet-spoke-prod'
  addressPrefixe: '12.0.0.0/16'
  subnets: [
    {
      name: 'subnet-apim-prod'
      addressPrefix: '12.0.1.0/24'
    }
  ]
}

var vnetHubConfiguration = {
  name: 'vnet-hub'
  addressPrefixe: '10.0.0.0/16'
  subnets: [
    {
      name: 'AzureFirewallSubnet'
      addressPrefix: '10.0.1.0/24'
    }
    {
      name: 'AzureBastionSubnet'
      addressPrefix: '10.0.2.0/26'
    }    
    {
      name: 'snet-jumpbox'
      addressPrefix: '10.0.3.0/27'
    }     
  ]
}

var vnetOnPremiseConfiguration = {
  name: 'vnet-onpremise'
  addressPrefixe: '150.0.0.0/16'
  subnets: [
    {
      name: 'snet-api-server'
      addressPrefix: '150.0.1.0/24'
    }
    {
      name: 'snet-api-gateway'
      addressPrefix: '150.0.2.0/24'
    }
    {
      name: 'snet-client'
      addressPrefix: '150.0.3.0/24'
    }        
  ]
}

// Create resource group

//var suffixDev = uniqueString(devSpoke.id)
var suffixProd = uniqueString(prodSpoke.id)
var suffixHub = uniqueString(hub.id)

var hubResourceGroup = 'rg-hub'
//var spokeDevResourceGroupName = 'rg-apim-dev-spoke'
var spokeProdResourceGroupName = 'rg-apim-prod-spoke'
var onPremiseResourceGroupName = 'rg-onpremise'

resource hub 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: hubResourceGroup
  location: location
}

// resource devSpoke 'Microsoft.Resources/resourceGroups@2021-04-01' = {
//   name: spokeDevResourceGroupName
//   location: location
// }

resource prodSpoke 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: spokeProdResourceGroupName
  location: location
}

resource onpremiseRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: onPremiseResourceGroupName
  location: location
}

// End create resource group

// Create the hub

module vnetHub 'modules/networking/vnet.hub.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'hub-vnet'
  params: {
    location: location
    vnetConfiguration: vnetHubConfiguration
  }
}

module azureFirewall 'modules/firewall/azureFirewall.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'firewall'
  params: {
    location: location
    subnetId: vnetHub.outputs.subnets[0].id
    suffix: suffixHub
  }
}

module bastion 'modules/bastion/azureBastion.bicep' = {
  scope: resourceGroup(hubResourceGroup)
  name: 'bastion'
  params: {
    location: location
    subnetId: vnetHub.outputs.subnets[1].id
    suffix: suffixHub
  }
}


// End create hub

// Create dev spoke

// module nsgApimDev 'modules/networking/nsg.apim.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'nsg-apim-dev'
//   params: {
//     location: location
//   }
// }

// module vnetSpokeDev 'modules/networking/vnet.spoke.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'vnet-spoke-dev'
//   params: {
//     name: 'vnet-spoke-dev'
//     location: location
//     vnetConfiguration: vnetSpokeDevConfiguration
//     nsgId: nsgApimDev.outputs.nsgId
//   }
// }

// module pipDevApim 'modules/networking/public-ip.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'pipDevApim'
//   params: {
//     location: location
//     name: 'pip-dev-apim-${suffixDev}'
//   }
// }

// module apimDev 'modules/apim/apim.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'apim-dev'
//   params: {
//     location: location
//     name: 'apim-dev-${suffixDev}'
//     publisherEmail: publisherEmail
//     publisherName: publisherName
//     pipId: pipDevApim.outputs.publicIp
//     apimSubnetId: vnetSpokeDev.outputs.subnetIdOne    
//     tags: {
//       environment: 'dev'
//     }    
//   }
// }

// module insightDev 'modules/appInsight/appinsight.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'insightDev'
//   params: {
//     location: location
//     suffix: suffixDev
//   }
// }

// module aspDev 'modules/web/appservice.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'aspDev'
//   params: {
//     location: location
//     suffix: suffixDev
//   }
// }

// module webSWDev 'modules/web/webapp.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'webDev'
//   params: {
//     location: location    
//     appInsightsName: insightDev.outputs.appInsightName
//     aspName: aspDev.outputs.aspName
//     webappname: 'web-starwars-api-dev-${suffixDev}'
//   }
// }

// module webFiboDev 'modules/web/webapp.bicep' = {
//   scope: resourceGroup(devSpoke.name)
//   name: 'webfiboDev'
//   params: {
//     location: location    
//     appInsightsName: insightDev.outputs.appInsightName
//     aspName: aspDev.outputs.aspName
//     webappname: 'web-fibonacci-api-dev-${suffixDev}'
//   }
// }

// End create dev spoke


// Create prod spoke

module nsgApimProd 'modules/networking/nsg.apim.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'nsg-apim-prod'
  params: {
    location: location
  }
}

module vnetSpokeProd 'modules/networking/vnet.spoke.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'vnet-spoke-prod'
  params: {
    name: 'vnet-spoke-prod'
    location: location
    vnetConfiguration: vnetSpokeProdConfiguration
    nsgId: nsgApimProd.outputs.nsgId
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
    apimSubnetId: vnetSpokeProd.outputs.subnetIdOne
    pipId: pipProdApim.outputs.publicIp
    tags: {
      environment: 'prod'
    }
  }
}

module insightProd 'modules/appInsight/appinsight.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'insightProd'
  params: {
    location: location
    suffix: suffixProd
  }
}

module aspProd 'modules/web/appservice.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'aspProd'
  params: {
    location: location
    suffix: suffixProd
  }
}

module webSWProd 'modules/web/webapp.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'webProd'
  params: {
    location: location    
    appInsightsName: insightProd.outputs.appInsightName
    aspName: aspProd.outputs.aspName
    webappname: 'web-starwars-api-prod-${suffixProd}'
  }
}

module webFiboProd 'modules/web/webapp.bicep' = {
  scope: resourceGroup(prodSpoke.name)
  name: 'webfiborod'
  params: {
    location: location    
    appInsightsName: insightProd.outputs.appInsightName
    aspName: aspProd.outputs.aspName
    webappname: 'web-fibonacci-api-prod-${suffixProd}'
  }
}

// End create prod spoke

// Create on premise resources

module vnetOnPrem 'modules/onpremise/networking.bicep' = {
  scope: resourceGroup(onpremiseRg.name)
  name: 'vnet-onprem'
  params: {    
    location: location
    vnetConfiguration: vnetOnPremiseConfiguration
  }
}


// end on premise resource

//output apimDevName string = apimDev.outputs.apimName
output apimProdName string = apimProd.outputs.apimName
//output webSWDevName string = webSWDev.outputs.appName
output webSWProdName string = webSWProd.outputs.appName
//output webFiboDevName string = webFiboDev.outputs.appName
output webFiboProdName string = webFiboProd.outputs.appName
//output rgDevSpokeName string = spokeDevResourceGroupName
