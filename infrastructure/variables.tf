variable "location" {
  type        = string
  description = "Location of the resource group and modules"
}

variable "prefix" {
  type        = string
  description = "Prefix for module names"
}

variable "environment" {
  type        = string
  description = "Environment information"
}

variable "postfix" {
  type        = string
  description = "Postfix for module names"
}

variable "enable_aml_computecluster" {
  description = "Variable to enable or disable AML compute cluster"
}

variable "enable_aml_secure_workspace" {
  description = "Variable to enable or disable AML secure workspace"
}

variable "jumphost_username" {
  type        = string
  description = "VM username"
  default     = "azureuser"
}

variable "jumphost_password" {
  type        = string
  description = "VM password"
  default     = "ThisIsNotVerySecure!"
}

variable "enable_monitoring" {
  description = "Variable to enable or disable Monitoring"
}

variable "enable_feature_store" {
  description = "Variable to enable or disable feature store deployment"
}

variable "client_secret" {
  description = "Service Principal Secret"
}

variable "sql_admin_user" {
  description = "SQL admin user name, for Synapse"
}

variable "sql_admin_password" {
  description = "SQL admin password, for Synapase"
}

variable "fs_onlinestore_conn_name" {
  type        = string
  description = "feature store: Name of the secret for the online store connection string"
}

variable "feathr_app_image" {
  type        = string
  description = "Feathr app image name to pull from docker registry"
}

variable "feathr_app_image_tag" {
  type        = string
  description = "Feathr app image tag to pull from docker registry"
}

variable "react_enable_rbac" {
  type        = bool
  description = "Enable RBAC for the Feathr React App"
}

variable "aad_client_id" {
  type        = string
  description = "AAD Client ID"
}
