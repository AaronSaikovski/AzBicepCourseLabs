@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountType string = 'Standard_LRS'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Do we deploy the storage account or not?')
param deployStorageAccount bool = true

@description('Storage loop counter')
@minValue(1)
param storageLoopCount int = 1

//loop over the storage account for storageLoopCount and check if we are to deploy a storage account based on a condition
resource storageAccountLoop 'Microsoft.Storage/storageAccounts@2021-06-01' = [for i in range(0, storageLoopCount): if (deployStorageAccount) {
    name: '${i}storage${uniqueString(resourceGroup().id)}' //dynamic name based on loop
    location: location
    sku: {
      name: storageAccountType
    }
    kind: 'StorageV2'
    properties: {}
}]

//loop over outputs...will error if deployStorageAccount set to false
output storageInfo array = [for i in range(0, storageLoopCount): {
  id: storageAccountLoop[i].id
  name:storageAccountLoop[i].name
  blobEndpoint: storageAccountLoop[i].properties.primaryEndpoints.blob
  status: storageAccountLoop[i].properties.statusOfPrimary
}]
