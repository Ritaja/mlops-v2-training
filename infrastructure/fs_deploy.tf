# TODO: currently the resource group will always be deployed as count on modules will still cause the 
# downstream modules (e.g. storage account) to still evaluate other variables and throw an error

locals {
  fsprefix = "${var.prefix}-fs"
}

# Resource group for feature store

module "resource_group_fs" {

  source = "./modules/resource-group"

  location = var.location

  prefix  = local.fsprefix
  postfix = var.postfix
  env     = var.environment

  tags = local.tags
}

# Storage account

module "storage_account_fs" {
  # Deploy conditionally based on Feature Flag variable
  count = var.enable_feature_store == true ? 1 : 0

  source = "./modules/storage-account"

  rg_name  = module.resource_group_fs.name
  location = module.resource_group_fs.location

  prefix  = local.fsprefix
  postfix = var.postfix
  env     = var.environment

  hns_enabled                         = true
  firewall_bypass                     = ["AzureServices"]
  firewall_virtual_network_subnet_ids = []
  enable_aml_secure_workspace         = var.enable_aml_secure_workspace
  vnet_id                             = var.enable_aml_secure_workspace ? azurerm_virtual_network.vnet_default[0].id : ""
  subnet_id                           = var.enable_aml_secure_workspace ? azurerm_subnet.snet_default[0].id : ""
  enable_feature_store                = var.enable_feature_store

  tags = local.tags
}

# Redis cache

module "redis_cache_fs" {
  # Deploy conditionally based on Feature Flag variable
  count = var.enable_feature_store == true ? 1 : 0

  source = "./modules/redis-cache"

  rg_name  = module.resource_group_fs.name
  location = module.resource_group_fs.location

  prefix  = local.fsprefix
  postfix = var.postfix
  env     = var.environment

  tags = local.tags
}

# Key vault

module "key_vault_fs" {
  # Deploy conditionally based on Feature Flag variable
  count = var.enable_feature_store == true ? 1 : 0

  source = "./modules/key-vault"

  rg_name  = module.resource_group_fs.name
  location = module.resource_group_fs.location

  prefix                      = local.fsprefix
  postfix                     = var.postfix
  env                         = var.environment
  enable_aml_secure_workspace = var.enable_aml_secure_workspace
  vnet_id                     = var.enable_aml_secure_workspace ? azurerm_virtual_network.vnet_default[0].id : ""
  subnet_id                   = var.enable_aml_secure_workspace ? azurerm_subnet.snet_default[0].id : ""
  fs_onlinestore_conn_name    = var.fs_onlinestore_conn_name
  fs_onlinestore_conn         = var.enable_feature_store ? module.redis_cache_fs[0].primary_connection_string : ""
  enable_feature_store        = var.enable_feature_store

  tags = local.tags
}

# Synapse workspace

module "synapse_workspace" {
  # Deploy conditionally based on Feature Flag variable
  count = var.enable_feature_store == true ? 1 : 0

  source = "./modules/synapse-workspace"

  rg_name  = module.resource_group_fs.name
  location = module.resource_group_fs.location

  prefix             = local.fsprefix
  postfix            = var.postfix
  env                = var.environment
  storage_account_id = module.storage_account_fs[0].filesystem_id
  #storage_account_id = azurerm_storage_data_lake_gen2_filesystem.example.id
  sql_admin_user     = var.sql_admin_user
  sql_admin_password = var.sql_admin_password

  tags = local.tags
}
