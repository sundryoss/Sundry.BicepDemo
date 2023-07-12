targetScope = 'managementGroup'  // Setting target scope
// targetScope = 'tenant' - if deploying at the tenant scop

param subscriptionId string
param resourceGroupName string = 'rg-contoso'
param dateTime string = utcNow()  // Just to make resource group deployment name unique
param location string = 'westus2'

// Deploying the resource group and a storage account inside of it
module rg './modules/resource-group.bicep' = {
  name: 'resourceGroupDeployment-${dateTime}'
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
  scope: subscription(subscriptionId)  // Passing subscription scope
}


module stg './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'stcontoso'
    location:location
  }
  scope: resourceGroup(subscriptionId,rg.name)  // Passing resource group scope
}
