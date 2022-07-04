resource "null_resource" "linux_provisioner_3385" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux-vm_3385]

  provisioner "remote-exec" {
    inline = ["/usr/bin/hostname"]
    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = element(azurerm_public_ip.linux-pip_3385[*].fqdn, count.index + 1)
    }
  }
}