# get the subscription ID
SUBSCRIPTION_ID=$(az account show --query 'id' --output tsv)

sqlAdminUsername="sqladmin"
sqlAdminPassword="ThisIsNotVerySecure!"
resourcePrefix="feathr"
azureADClientId="d5d082e1-641e-46a3-b681-81c885f355ab"
azureADTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
location="eastus2"

