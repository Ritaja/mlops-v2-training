resource "azurerm_mssql_server" "mssql_server" {
  name                         = "sql${var.prefix}${var.postfix}${var.env}"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  tags = var.tags
}

resource "azurerm_mssql_database" "mssql_db" {
  name           = "db${var.prefix}${var.postfix}${var.env}"
  server_id      = azurerm_mssql_server.mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = var.tags
}

# this is the current wa to allow Azure internal IP to access the SQL server, update when necessary
resource "azurerm_sql_firewall_rule" "allow_azure_internal" {
  name                = "Allow Azure Internal"
  resource_group_name = var.rg_name
  server_name         = azurerm_sql_server.mssql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
