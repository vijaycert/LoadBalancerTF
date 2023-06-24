resource "azurerm_virtual_network" "TFVNetwork1" {
  name                = var.vVnet_name
  location            = var.vnet_location
  resource_group_name = var.resource_group_name
  address_space       = var.vVnet_address_space

  tags = {
    environment = "Development"
  }
}

resource "azurerm_subnet" "TFSubnet1" {
  name           = var.vSubnet_Lin_name
  address_prefixes = var.vSubnet_Lin_space
  resource_group_name = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.TFVNetwork1.name

  depends_on = [ azurerm_virtual_network.TFVNetwork1 ]

}

resource "azurerm_network_security_group" "TFNSG1" {
  name                = "TfAzLbNSG1"
  location            = var.vnet_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "secrule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_subnet_network_security_group_association" "NSGAssociation" {
  subnet_id                 = azurerm_subnet.TFSubnet1.id
  network_security_group_id = azurerm_network_security_group.TFNSG1.id
}