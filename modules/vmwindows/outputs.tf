output "Windows_hostname" {
  value = azurerm_windows_virtual_machine.windows-vm_3385.name
}

output "Windows_public_ip_addresses" {
    value = azurerm_windows_virtual_machine.windows-vm_3385.public_ip_address
}

output "Windows_private_ip_address" {
  value = azurerm_windows_virtual_machine.windows-vm_3385.private_ip_address
}

output "Windows_dns" {
  value = azurerm_public_ip.windows-pip_3385.domain_name_label
}

output "Windows_vm" {
  value = azurerm_windows_virtual_machine.windows-vm_3385
}