resource "azurerm_network_interface" "linux-nic_3385" {
  count               = var.nb_count
  name                = "${var.linux_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = local.common_tags


  ip_configuration {
    name                          = "${var.linux_name}-ipconfig-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.linux-pip_3385[*].id, count.index + 1)
  }
}

resource "azurerm_public_ip" "linux-pip_3385" {
  count               = var.nb_count
  name                = "${var.linux_name}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.resource_group
  location            = var.location
  domain_name_label   = "${var.linux_name}-dns-${format("%1d", count.index + 1)}"
  allocation_method   = "Static"
  tags                = local.common_tags

}

resource "azurerm_linux_virtual_machine" "linux-vm_3385" {
  count               = var.nb_count
  name                = "${var.linux_name}-vm-${format("%1d", count.index + 1)}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_B1ms"
  computer_name       = "${var.linux_name}-cn-${format("%1d", count.index + 1)}"
  tags                = local.common_tags

  availability_set_id = azurerm_availability_set.linux-avs_3385.id
  network_interface_ids = [
    element(azurerm_network_interface.linux-nic_3385[*].id, count.index + 1)
  ]
  admin_username      = "n01523385"
  admin_password      = "n01523385@arunima"
  disable_password_authentication = false

  os_disk {
    name                 = "${var.linux_name}-os-disk-${format("%1d", count.index + 1)}"
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  depends_on = [azurerm_availability_set.linux-avs_3385]
}

resource "azurerm_availability_set" "linux-avs_3385" {
  name                         = "linux-avs-3385"
  location                     = var.location
  resource_group_name          = var.resource_group
  platform_update_domain_count = 10
  platform_fault_domain_count  = 2
}

resource "azurerm_virtual_machine_extension" "linux-vme_3385" {
  count               = var.nb_count
  name                = "${var.linux_name}-vme-${format("%1d", count.index + 1)}"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux-vm_3385[count.index].id
  publisher  = "Microsoft.Azure.NetworkWatcher"
  type  = "NetworkWatcherAgentLinux"
  type_handler_version ="1.4"
  depends_on = [null_resource.linux_provisioner_3385]
  tags                = local.common_tags
}
