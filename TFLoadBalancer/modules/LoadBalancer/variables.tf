variable "resource_group_name" {
  type=string
  description = "Resource group name"
}

variable "vm_location" {
  type = string
  description = "name of location"
}

variable "vnet_id" {
  type = string
}

variable "vm01_ip_address" {
  type= string
}

variable "vm02_ip_address" {
  type= string
}