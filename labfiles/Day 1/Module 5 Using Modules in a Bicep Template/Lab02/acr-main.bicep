/*
SUMMARY: Builds a Private Container registry for Bicep resource modules
DESCRIPTION: The following components will be required parameters in this deployment
    Name
    Location
    SKU    
    ResourceGroup
    Tags   

AUTHOR/S: asaikovski
VERSION: 1.0.1
*/

@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param name string = 'acr${uniqueString(resourceGroup().id)}'

@description('Provide a location for the registry.')
param location string = resourceGroup().location

@description('Provide a tier of your Azure Container Registry.')
@allowed([
  'Basic'
  'Premium'
  'Standard'
])
param acrsku string = 'Basic'

@description('Tags to be applied to resource when deployed.  Default: None')
param tags object ={}

//Resources
resource acr 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: name
  tags: tags
  location: location
  sku: {
    name: acrsku
  }
  properties: {
    adminUserEnabled: false
  }
}

@description('Output the login server property for later use')
output outLoginServer string = acr.properties.loginServer
