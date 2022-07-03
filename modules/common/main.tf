resource "azurerm_log_analytics_workspace" "log_analytics_workspace_3385" {
  name = "loganalyticsworkspace-3385"
  location = var.location
  resource_group_name = var.resource_group
  sku = "PerGB2018"
  retention_in_days = 30
  tags = local.common_tags
}
resource "azurerm_recovery_services_vault" "recovery_services_vault_3385" {
  name                = "vault-3385"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  soft_delete_enabled = true
  tags = local.common_tags
}
resource "azurerm_storage_blob" "storage_blob_3385" {
  name                   = "storageblob_3385"
  storage_account_name   = azurerm_storage_account.storage_account_3385.name
  storage_container_name = azurerm_storage_container.storage_container_3385.name
  type                   = "Block"
}
resource "azurerm_storage_account" "storage_account_3385" {
    name = "storageaccount3385"
    resource_group_name = var.resource_group
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = local.common_tags
}
resource "azurerm_storage_container" "storage_container_3385" {
  name = "storagecontainer-3385"
  storage_account_name = azurerm_storage_account.storage_account_3385.name
  container_access_type = "private"
}