variable "resource_group_name" {
  type=string
  description = "Resource group name"
}

variable "vnet_location" {
  type = string
  description = "name of location"
}

variable "vVnet_name" {
  type = string
}

variable "vVnet_address_space" {
  type = list(string)
}

variable "vSubnet_Lin_name" {
  type = string
}

variable "vSubnet_Lin_space" {
  type = list(string)
}

