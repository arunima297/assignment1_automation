resource "azurerm_lb" "loadbalancer_3385" {
  name                = var.loadbalancer["name"]
  location            = var.location
  resource_group_name = var.resource_group
  frontend_ip_configuration {
    name                 = "PublicIPAddress_1"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip_3385[0].id
  }
  frontend_ip_configuration {
    name = "PublicIPAddress_2"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip_3385[1].id
  }
  tags = local.common_tags
}
resource "azurerm_public_ip" "loadbalancer-pubip_3385" {
  count               = 2
  name                = "${var.loadbalancer-pubip}-lbpip-1${format("%1d", count.index + 1)}"
  domain_name_label   = "lbdns-1${format("%1d", count.index + 1)}"
  allocation_method   = "Static"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = local.common_tags
}
resource "azurerm_network_interface_backend_address_pool_association" "loadbalancer_pool_association_3385" {
  for_each = var.linux_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool_3385.id
  network_interface_id = element(var.linux_network_interface_id, 0)[0][each.value]
  ip_configuration_name = "linuxvm-3385-ipconfig-${each.value + 1}"
}
resource "azurerm_lb_backend_address_pool" "backend_address_pool_3385" {
  loadbalancer_id = azurerm_lb.loadbalancer_3385.id
  name = var.backend_address_pool
}
resource "azurerm_lb_probe" "loadbalancer_probe_3385" {
    loadbalancer_id = azurerm_lb.loadbalancer_3385.id
    name = "loadbalancer-probe_3385"
    protocol = "Tcp"
    port = 80
    interval_in_seconds = 5
    number_of_probes = 2
}
resource "azurerm_lb_rule" "loadbalancer_rule_3385" {
  count = 2
  loadbalancer_id = azurerm_lb.loadbalancer_3385.id
  name = "${var.loadbalancer_rule["name"]}-${format("%1d", count.index + 1)}"
  protocol = var.loadbalancer_rule["protocol"]
  frontend_port = var.loadbalancer_rule["frontend_port"]
  backend_port = var.loadbalancer_rule["backend_port"]
  frontend_ip_configuration_name = "PublicIPAddress_${format("%1d", count.index + 1)}"
}