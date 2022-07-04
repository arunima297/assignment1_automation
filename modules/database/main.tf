resource "azurerm_postgresql_database" "database_3385" {
  name                = "database-3385"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.postsql_server_3385.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
resource "azurerm_postgresql_server" "postsql_server_3385" {
  name = "postgresql-server-3385"
  location = var.location
  resource_group_name = var.resource_group
  sku_name = "B_Gen5_2"
  storage_mb = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled = true
  administrator_login = "n01523385"
  administrator_login_password = "n0152@3385"
  version = "11"
  ssl_enforcement_enabled = true
  tags = local.common_tags
}