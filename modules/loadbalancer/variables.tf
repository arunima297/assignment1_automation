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
variable "loadbalancer-pubip" {
    default = "loadbalancer_pubip-3385"
}
variable "loadbalancer" {
    type = map(string) 
    default = {
        name    = "loadbalancer-3385"
        frontend_ip_configuration = "pubip-3385"
    }
}
variable "linux_network_interface_id" {
    default = ""
}
variable "linux_network_interface_name" {
    default = ""
}
variable "linux_pip_id" {
    default = ""
}
variable "linux_name" {
    default = ""
}
variable "loadbalancer_rule" {
    type = map(string) 
    default = {
        name = "loadbalancer-rule_3385"
        frontend_ip_configuration_name = "PublicIPAddress_3385"
        protocol = "Tcp"
        frontend_port = 3389
        backend_port = 3389
    }
}
variable "backend_address_pool" {
    default = "backendaddresspool_3385"
}
variable "loadbalancer_pool_association" {
    default = "loadbalancer-pool-association-3385"
}