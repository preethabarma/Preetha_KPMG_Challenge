#Create Random password 
resource "random_password" "randompassword" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

#Create Key Vault Secret
resource "azurerm_key_vault_secret" "sqladminpassword" {
  name         = "sqladmin"
  value        = random_password.randompassword.result
  key_vault_id = azurerm_key_vault.demo-keyvault.id
  content_type = "text/plain"
  depends_on = [
    azurerm_key_vault.demo-keyvault, azurerm_key_vault_access_policy.kv_access_policy_01
  ]
}

#Azure sql server
resource "azurerm_mssql_server" "azuresql" {
  name                         = "demo-sqldb-test101"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "4adminu$er"
  administrator_login_password = random_password.randompassword.result

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = var.object_id
  }
}

#Allow communication from the backend subnet to SQL Db
#Allows you to manage rules for allowing traffic between an Azure SQL server and a subnet of a virtual network.
resource "azurerm_mssql_virtual_network_rule" "allow-be" {
  name      = "be-sql-vnet-rule"
  server_id = azurerm_mssql_server.azuresql.id
  subnet_id = azurerm_subnet.be-subnet.id
  depends_on = [
    azurerm_mssql_server.azuresql
  ]
}


#Azure sql Db
resource "azurerm_mssql_database" "demo-database" {
  name           = "demo-db"
  server_id      = azurerm_mssql_server.azuresql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    Application = "test-demo"
  }
}

resource "azurerm_key_vault_secret" "sqldb_cnxn" {
  name         = "demosqldbconstring"
  value        = "jdbc:sqlserver://demo-sqldb-test101.database.windows.net:1433;database=demo-db;user=4adminu$er@demo-sqldb-test101;password=${random_password.randompassword.result};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"
  key_vault_id = azurerm_key_vault.demo-keyvault.id
  depends_on = [
    azurerm_mssql_database.demo-database, azurerm_key_vault_access_policy.kv_access_policy_01
  ]
}
