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
  