param ApimServiceName string
param WebUrl string

resource apim 'Microsoft.ApiManagement/service@2023-05-01-preview' existing = {
  name: ApimServiceName
}

resource ApimServiceName_fibonacci 'Microsoft.ApiManagement/service/apis@2023-05-01-preview' = {  
  name: 'PizzaApi'
  parent: apim
  properties: {
    apiRevision: '2'
    isCurrent: true
    subscriptionRequired: true
    displayName: 'PizzaApi'    
    format: 'openapi+json'
    value: loadTextContent('./openapi.yml')
    serviceUrl: WebUrl
    path: 'Fibo'
    protocols: [
      'https'
    ]
  }  
  dependsOn: []
}
