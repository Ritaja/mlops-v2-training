$Env:SUBSCRIPTION_ID = (az account show --query 'id' --output tsv)

$Env:sqlAdminUsername = "sqladmin"
$Env:sqlAdminPassword = "ThisIsNotVerySecure!"
$Env:resourcePrefix = "rs-feathr"
$Env:azureADClientId = "d5d082e1-641e-46a3-b681-81c885f355ab"
$Env:azureADTenantId = "72f988bf-86f1-41af-91ab-2d7cd011db47"
$Env:location = "francecentral"

# register the Purview resource provider
az provider register --namespace 'Microsoft.Purview'
# check the registration status, proceed when you see "Registered"
az provider show -n Microsoft.Purview --query registrationState -o tsv
# create the resource group
az group create -l "$Env:location" -n "$Env:resourcePrefix-rg"
# deploy feature store resources
az deployment group create -g "$Env:resourcePrefix-rg" --template-file "./azuredeploy.json" --parameters "@azuredeploy.parameters.json"