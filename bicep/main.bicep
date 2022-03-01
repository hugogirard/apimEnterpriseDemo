@description('The location of the Azure resources')
param location string

@description('The email of the publisher')
param publisherEmail string

@description('The name of the publisher')
param publisherName string

var suffix = uniqueString(resourceGroup().id)

module apim 'modules/apim/apim.bicep' = {
  name: 'apim'
  params: {
    location: location 
    publisherEmail: publisherEmail
    publisherName: publisherName
    suffix: suffix
  }
}

module appplan 'modules/web/appserviceplan.bicep' = {
  name: 'appplan'
  params: {
    location: location
    suffix: suffix
  }
}

module webapp 'modules/web/webapp.bicep' = {
  name: 'webapp'
  params: {
    appServicePlanId: appplan.outputs.appServiceId
    location: location
    suffix: suffix
  }
}

output webappName string = webapp.outputs.webappName
