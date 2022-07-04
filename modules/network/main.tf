resource "azurerm_virtual_network" "vnet_3385" {
  name                = var.vnet
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.vnet_space

  tags = local.common_tags
}

resource "azurerm_subnet" "subnet_3385" {
  name                 = var.subnet
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet_3385.name
  address_prefixes     = var.subnet_space
}