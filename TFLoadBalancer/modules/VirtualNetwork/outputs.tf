output "vnet_name_out" {
    value = azurerm_virtual_network.TFVNetwork1.name
}

output "vnet_id_out" {
    value = azurerm_virtual_network.TFVNetwork1.id
}

output "subnet_name_out" {
    value = azurerm_subnet.TFSubnet1.name
}

output "subnet_id_out" {
    value = azurerm_subnet.TFSubnet1.id
}