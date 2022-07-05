
locals {
  common_tags = {
    Name            = "Arunima.Das"
    Project         = "Automation Project-Assignment 1"
    ExpirationDate  = "2022-06-30"
    Enviroment      = "Lab"
  }
}

variable "resource_group"{
    default = ""
}

variable "location" {
    default = ""
}

variable "subnet_id" {
    default = ""
}

variable "windows_name" {
  default = ""
}

variable "windows_size" {
  default = "Standard_B1ms"
}

variable "admin_username" {
  default = "n01523385"
}

variable "admin_password" {
  default = "n01523385@arunima"
}

variable windows_os_disk {
    type = map(string)
    default = {
        create_option = "Attach"
        storage_account_type = "StandardSSD_LRS"
        disk_size = 128
        caching = "ReadWrite"
    }
}

variable "windows_avs" {
    default = "windows_avs"
}
variable "storage_account_uri" {
    default = ""
}

variable "windows_vmexe" {
  type = map(string)
  default = {
    publisher  = "Microsoft.Azure.Security.AntimalwareSignature"
    type  = "AntimalwareConfiguration"
    type_handler_version ="2.58"
  }
}

