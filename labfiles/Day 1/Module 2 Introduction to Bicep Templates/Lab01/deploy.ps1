##Deploy ARM teplate using powershell

#Login to Azure
#Login-AzAccount
    
#Vars
$subscriptionName="<SUBSCRIPTION_NAME>"
$resourceGroupName="simple-storageesource-demo-rg"
$location="Australia East"
$deploymentName="SimpleStorageDeployment"
$bicepSrc="simple-storage-deploy.bicep"
$armOutput="simple-storage-deploy.json"
$templateParamFile="simple-storage.parameters.json"

#Select Subscription
$subscriptionId = (Get-AzSubscription -SubscriptionName $subscriptionName).Id
Select-AzSubscription -SubscriptionId $subscriptionId  

#Create Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

#Convert Bicep to .JSON ARM template - issues with cmdlet - New-AzResourceGroupDeployment
az bicep build --file $bicepSrc

#Deploy the Decompiled ARM template with param file
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $armOutput `
  -TemplateParameterFile $templateParamFile ##-WhatIf
  
  ##-AsJob

#Remove Resource Group
##Remove-AzResourceGroup -Name $resourceGroupName -Force -AsJob


