##Deploy ARM teplate using powershell

#Login to Azure
#Login-AzAccount
    
#Vars
$subscriptionName="<SUBSCRIPTION_NAME>"
$resourceGroupName="storage-modules-demo-rg"
$location="Australia East"
$deploymentName="SimpleStorageDeployment"
$bicepSrc="containerregistry-parameters.bicep"
$armOutput="containerregistry-parameters.json"

$acrname="demoazuregistry"
$moduleReleaseVersion="v1.0.0"

#Select Subscription
$subscriptionId = (Get-AzSubscription -SubscriptionName $subscriptionName).Id
Select-AzSubscription -SubscriptionId $subscriptionId  

#Create Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

#Convert Bicep to .JSON ARM template - issues with cmdlet - New-AzResourceGroupDeployment
az bicep build --file $bicepSrc

#Deploy Azure Container registry for publishing images into
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $armOutput  ##-AsJob


#publish Storage Account
az bicep publish --file 'storage-module.bicep' --target br:$acrname.azurecr.io/bicep/modules/storage/storageaccounts:$moduleReleaseVersion

#Remove Resource Group
##Remove-AzResourceGroup -Name $resourceGroupName -Force -AsJob


