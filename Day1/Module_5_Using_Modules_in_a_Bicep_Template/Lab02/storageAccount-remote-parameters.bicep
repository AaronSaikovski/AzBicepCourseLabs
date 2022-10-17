//REMOTE Module Reference
@description('Optional. The location to deploy into')
param location string = resourceGroup().location

@description('Generate random storage account name')
param storageAccountName string = 'rem${uniqueString(resourceGroup().id)}'

module storage 'br/demoazureregistry:storage/storageaccounts:v1.0.0'= {
  name:'demostg'
  params:{
    storageAccountName:storageAccountName
    location:location
  }  
}
