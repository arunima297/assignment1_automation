variable "resource_group"{
    default = ""
}

variable "location" {
    default = ""
}

variable "subnet_id" {
    default = ""
}

variable "linux_name" {
  default = ""
}
locals {
  common_tags = {
    Name            = "Arunima.Das"
    Project         = "Automation Project-Assignment 1"
    ExpirationDate  = "2022-06-30"
    Enviroment      = "Lab"
  }
}
variable "storage_account_uri" {
    default = ""
}

variable "nb_count" {
  default = ""
}
