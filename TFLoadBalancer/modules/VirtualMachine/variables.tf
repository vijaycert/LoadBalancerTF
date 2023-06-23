variable "vLinux_VM_name" {
  type = string
}

variable "resource_group_name" {
  type=string
  description = "Resource group name"
}

variable "vm_location" {
  type = string
  description = "name of location"
}

variable "vLinux_VM_size" {
  type = string
}

variable "subnet_id"{
  type=string
}

variable "vVM_Nic_name" {
  type = string
}

variable "lin_public_ip" {
  type= string
}