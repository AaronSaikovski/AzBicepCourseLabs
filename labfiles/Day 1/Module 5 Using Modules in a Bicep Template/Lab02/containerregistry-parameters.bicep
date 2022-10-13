
/*
SUMMARY: Parameters file for the  Private Container registry for Bicep resource modules
DESCRIPTION: The following components will be required parameters in this deployment
    Name - Deployment name
    Name
    Location
    SKU 
AUTHOR/S: asaikovski
VERSION: 1.0.0
*/

param location string = resourceGroup().location

module acr 'acr-main.bicep' = {
  name:'acr-demo'
  params:{
    name:'demoazuregistry'
    acrsku:'Basic'
    location:location
  }
}
