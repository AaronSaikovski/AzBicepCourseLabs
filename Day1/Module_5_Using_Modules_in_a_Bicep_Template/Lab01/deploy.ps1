##Deploy ARM teplate using powershell

#Login to Azure
#Login-AzAccount
    
#Vars
$subscriptionName="<SUBSCRIPTION_NAME>"
$resourceGroupName="storage-modules-demo-rg"
$location="Australia East"
$deploymentName="SimpleStorageDeployment"

$bicepLocalSrc="storageaccount-local-parameters.bicep"
$armLocalOutput="storageaccount-local-parameters.json"

#Select Subscription
$subscriptionId = (Get-AzSubscription -SubscriptionName $subscriptionName).Id
Select-AzSubscription -SubscriptionId $subscriptionId  

#Create Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

#Convert Bicep to .JSON ARM template - issues with cmdlet - New-AzResourceGroupDeployment
az bicep build --file $bicepLocalSrc

#Deploy the Decompiled ARM template with param file - Local module
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $armLocalOutput ##-AsJob

#Remove Resource Group
##Remove-AzResourceGroup -Name $resourceGroupName -Force -AsJob


