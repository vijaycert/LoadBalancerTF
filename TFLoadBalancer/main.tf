# This is the main program which calls up the respective modules to create resources. 
# This program is a TF demo of Load Balancer using Azure. 

module "ResourceGroup" {
  source = "./modules/ResourceGroup"

  base_name = var.base_name
  location  = var.location
}

module "vnet" {
  source = "./modules/VirtualNetwork"

  resource_group_name = module.ResourceGroup.rg_name_out
  vnet_location       = var.location

  vVnet_name          = var.vVnet_name
  vVnet_address_space = var.vVnet_address_space
  vSubnet_Lin_name    = var.vSubnet_name
  vSubnet_Lin_space   = var.subnet_prefix
}

module "vmachine01" {
  source = "./modules/VirtualMachine"

  resource_group_name = module.ResourceGroup.rg_name_out
  vm_location         = var.location
  #vVnet_name          = module.vnet.vnet_name_out
  subnet_id      = module.vnet.subnet_id_out
  vLinux_VM_size = "Standard_B1s"
  vLinux_VM_name = var.vVM01_name
  vVM_Nic_name   = var.vVM_Nic01_name
  lin_public_ip  = var.pip01_name
}

module "vmachine02" {
  source = "./modules/VirtualMachine"

  resource_group_name = module.ResourceGroup.rg_name_out
  vm_location         = var.location
  #vVnet_name          = module.vnet.vnet_name_out
  subnet_id      = module.vnet.subnet_id_out
  vLinux_VM_size = "Standard_B1s"
  vLinux_VM_name = var.vVM02_name
  vVM_Nic_name   = var.vVM_Nic02_name
  lin_public_ip  = var.pip02_name
}

module "vmachine03" {
  source = "./modules/VirtualMachine"

  resource_group_name = module.ResourceGroup.rg_name_out
  vm_location         = var.location
  #vVnet_name          = module.vnet.vnet_name_out
  subnet_id      = module.vnet.subnet_id_out
  vLinux_VM_size = "Standard_B1s"
  vLinux_VM_name = var.vVM03_name
  vVM_Nic_name   = var.vVM_Nic03_name
  lin_public_ip  = var.pip03_name
}

module "loadbalancer" {
  source              = "./modules/LoadBalancer"
  resource_group_name = module.ResourceGroup.rg_name_out
  vm01_ip_address     = module.vmachine01.privateIP_out
  vm02_ip_address     = module.vmachine02.privateIP_out
  vm_location         = var.location
  vnet_id             = module.vnet.vnet_id_out

}