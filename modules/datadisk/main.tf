resource "azurerm_managed_disk" "windows_data_disk_3385" {
  name = "${var.windows_name}-data-disk"
  location = var.location
  resource_group_name = var.resource_group
  disk_size_gb = 10
  storage_account_type = "Standard_LRS"
  create_option = "Empty"
  tags = local.common_tags
}
resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk_attach_3385" {
  for_each           = var.linux_name
  managed_disk_id    = azurerm_managed_disk.linux_data_disk_3385[each.key].id 
  virtual_machine_id = element(var.linux_id,0)[0][each.value]
  caching            = "ReadWrite"
  lun                = 0
  depends_on = [azurerm_managed_disk.linux_data_disk_3385]
}
resource "azurerm_managed_disk" "linux_data_disk_3385" {
  for_each             = var.linux_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = local.common_tags
  depends_on           = [var.depend_on]
}
resource "azurerm_virtual_machine_data_disk_attachment" "windows_data_disk_attach_3385" {
  managed_disk_id    = azurerm_managed_disk.windows_data_disk_3385.id
  virtual_machine_id = var.windows_id
  lun                = 0
  caching            = "ReadWrite"
  depends_on = [azurerm_managed_disk.windows_data_disk_3385]
}