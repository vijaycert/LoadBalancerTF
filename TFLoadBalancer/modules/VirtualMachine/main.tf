resource "azurerm_linux_virtual_machine" "TFModuleVM" {
  name                            = var.vLinux_VM_name
  location                        = var.vm_location
  resource_group_name             = var.resource_group_name
  size                            = var.vLinux_VM_size
  admin_username                  = "adminuser"
  admin_password                  = "admin123!"
  disable_password_authentication = false

  network_interface_ids = [ azurerm_network_interface.TFModuleNic.id ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "TfAzLbPublicIP" {
  name                = var.lin_public_ip
  location            = var.vm_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Development"
  }
  
}

resource "azurerm_network_interface" "TFModuleNic" {
  name                = var.vVM_Nic_name
  location            = var.vm_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm_ip_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.TfAzLbPublicIP.id
  }
}
