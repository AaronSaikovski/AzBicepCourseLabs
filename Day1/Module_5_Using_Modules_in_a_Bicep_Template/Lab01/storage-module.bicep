param storageAccountName string
param containerName string = 'logs'
param location string = resourceGroup().location

resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${sa.name}/default/${containerName}'
}

@description('Return the Storage Account Resource ID')
output blobResourceId string = sa.id

@description('Return the Storage Account Primary Endpoint')
output blobPrimaryEndpoint string = sa.properties.primaryEndpoints.blob

@description('Return the Storage Account Blob Container Resource ID')
output blobContainerResourceId string = container.id
