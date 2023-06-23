resource "azurerm_resource_group" "TFResourceGrp1" {
  name     = "${var.base_name}_RG"
  location = var.location

  tags = {
    environment = "Development"
  }
}