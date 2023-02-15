targetScope='subscription'

@description('The location where the resources will be deployed')
param location string

@description('The Publisher name of APIM')
@secure()
param publisherName string

@description('The email of the APIM admin')
@secure()
param publisherEmail string

var vnetSpokeDevConfiguration = {
  name: 'vnet-spoke-dev'
  addressPrefixe: '11.0.0.0/24'
  subnets: [
    {
      name: 'subnet-apim-dev'
      addressPrefix: '11.0.1.0/24'
    }
}

var suffixDev = uniqueString(devSpoke.id)
var suffixProd = uniqueString(prodSpoke.id)

var hubResourceGroup = 'rg-hub'
var spokeDevResourceGroupName = 'rg-apim-dev-spoke'
var spokeProdResourceGroupName = 'rg-apim-prod-spoke'
var onPremiseResourceGroupName = 'rg-onpremise'

resource hub 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: hubResourceGroup
  location: location
}

resource devSpoke 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: spokeDevResourceGroupName
  location: location
}

resource prodSpoke 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: spokeProdResourceGroupName
  location: location
}

module vnetSpokeDev 'modules/vnet/vnet.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'vnet-spoke-dev'
  params: {
    location: location
    vnetConfiguration: vnetSpokeDevConfiguration
  }
}

module apimDev 'modules/apim/apim.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'apim-dev'
  params: {
    location: location
    name: 'apim-dev-${suffixDev}'
    publisherEmail: publisherEmail
    publisherName: publisherName
    tags: {
      environment: 'dev'
    }
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
    tags: {
      environment: 'prod'
    }
  }
}

module insightDev 'modules/appInsight/appinsight.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'insightDev'
  params: {
    location: location
    suffix: suffixDev
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

module aspDev 'modules/web/appservice.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'aspDev'
  params: {
    location: location
    suffix: suffixDev
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

module webSWDev 'modules/web/webapp.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'webDev'
  params: {
    location: location    
    appInsightsName: insightDev.outputs.appInsightName
    aspName: aspDev.outputs.aspName
    webappname: 'web-starwars-api-dev-${suffixDev}'
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

module webFiboDev 'modules/web/webapp.bicep' = {
  scope: resourceGroup(devSpoke.name)
  name: 'webfiboDev'
  params: {
    location: location    
    appInsightsName: insightDev.outputs.appInsightName
    aspName: aspDev.outputs.aspName
    webappname: 'web-fibonacci-api-dev-${suffixDev}'
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

output apimDevName string = apimDev.outputs.apimName
output apimProdName string = apimProd.outputs.apimName
output webSWDevName string = webSWDev.outputs.appName
output webSWProdName string = webSWProd.outputs.appName
output webFiboDevName string = webFiboDev.outputs.appName
output webFiboProdName string = webFiboProd.outputs.appName
output rgDevSpokeName string = spokeDevResourceGroupName
