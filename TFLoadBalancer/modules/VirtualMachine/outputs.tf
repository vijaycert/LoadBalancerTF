output "privateIP_out" {
    value = azurerm_network_interface.TFModuleNic.private_ip_address
}