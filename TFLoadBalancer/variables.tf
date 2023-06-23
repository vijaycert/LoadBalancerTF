variable "base_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vVnet_name" {
  type = string
}

variable "vVnet_address_space" {
  type = list(string)
}

variable "vSubnet_name" {
  type = string
}

variable "subnet_prefix" {
  type = list(string)
}

variable "vVM01_name" {
  type = string
}

variable "vVM02_name" {
  type = string
}

variable "vVM03_name" {
  type = string
}

variable "vVM_Nic01_name" {
  type = string
}

variable "vVM_Nic02_name" {
  type = string
}

variable "vVM_Nic03_name" {
  type = string
}

variable "lin_public_ip" {
  type = string
}

variable "pip01_name" {
  type = string
}

variable "pip02_name" {
  type = string
}

variable "pip03_name" {
  type = string
}