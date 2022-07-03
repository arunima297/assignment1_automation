locals {
  common_tags = {
    Name            = "Arunima.Das"
    Project         = "Automation Project-Assignment 1"
    ExpirationDate  = "2022-06-30"
    Enviroment      = "Lab"
  }
}
variable "depend_on" {
    default = ""
}
variable "resource_group"{
    default = ""
}
variable "location" {
    default = ""
}
variable "windows_id" {
    default = ""
}
variable "linux_id" {
    default = ""
}
variable "windows_name" {
    default = ""
}
variable "linux_name" {
    default = ""
}