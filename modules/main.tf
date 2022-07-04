module "resource_group" {
  source   = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/resource_group"
  resource_group      = "3385-assignment1-RG"
  location = "australiacentral"
}

module "network" {
  source         = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/network"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
}

module "common" {
  source         = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/common"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on = [module.resource_group]
}

module "vmlinux" {
  source              = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/vmlinux"
  resource_group      = module.resource_group.resource_group.name
  location            = module.resource_group.resource_group.location
  nb_count            = 2
  depends_on          = [module.network]
  linux_name          = "linuxvm-3385"
  subnet_id           = module.network.subnet.id
  storage_account_uri = module.common.storage_account.primary_blob_endpoint
}

module "vmwindows" {
  source              = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/vmwindows"
  resource_group      = module.resource_group.resource_group.name
  location            = module.resource_group.resource_group.location
  depends_on          = [module.network]
  windows_name        = "windowvm-3385"
  subnet_id           = module.network.subnet.id
  storage_account_uri = module.common.storage_account.primary_blob_endpoint
}

module "datadisk" {
  source         = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/datadisk"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on = [
    module.vmlinux,
    module.vmwindows
  ]
  windows_name = module.vmwindows.Windows_hostname
  windows_id   = module.vmwindows.Windows_vm.id
  linux_name = {
    linuxvm-3385-1 = 0
    linuxvm-3385-2 = 1
  }
  linux_id = [module.vmlinux.Linux_id]
}

module "loadbalancer" {
  source         = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/loadbalancer"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  linux_name = {
    linuxvm-3385-1 = 0
    linuxvm-3385-2 = 1
  }
  linux_network_interface_id = [module.vmlinux.Linux_network_interface_id]
  linux_pip_id               = [module.vmlinux.Linux_public_ip_addresses_id]
  depends_on = [
    module.vmlinux,
    module.vmwindows,
    module.network
  ]
}

module "database" {
  source         = "C:/Users/unnim/Downloads/Humber/SEM02/AUTOMATION/terraform/Assignment_1/modules/database"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on     = [module.network]
}