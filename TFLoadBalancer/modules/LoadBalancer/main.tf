resource "azurerm_public_ip" "LB_PublicIP" {
  name                = "PublicIPForLB"
  location                        = var.vm_location
  resource_group_name             = var.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "TfAzLoadBalancer" {
  name                = "TestLoadBalancer"
  location                        = var.vm_location
  resource_group_name             = var.resource_group_name

  frontend_ip_configuration {
    name                 = "LBFePublicIP"
    public_ip_address_id = azurerm_public_ip.LB_PublicIP.id
  }
  sku = "Standard"
  depends_on = [ azurerm_public_ip.LB_PublicIP ]
}

resource "azurerm_lb_backend_address_pool" "TfAzLbBackendPool" {
  loadbalancer_id = azurerm_lb.TfAzLoadBalancer.id
  name            = "BackEndAddressPool"
  #virtual_network_id = var.vnet_id
}

resource "azurerm_lb_backend_address_pool_address" "TfAzLbBkndPoolAddrVM01" {
  name                                = "address1"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.TfAzLbBackendPool.id
  #backend_address_ip_configuration_id = azurerm_lb.TfAzLoadBalancer.frontend_ip_configuration[0].id
  virtual_network_id = var.vnet_id
  ip_address = var.vm01_ip_address
  depends_on = [ azurerm_lb_backend_address_pool.TfAzLbBackendPool ]
}

resource "azurerm_lb_backend_address_pool_address" "TfAzLbBkndPoolAddrVM02" {
  name                                = "address2"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.TfAzLbBackendPool.id
  #backend_address_ip_configuration_id = azurerm_lb.TfAzLoadBalancer.frontend_ip_configuration[0].id
  virtual_network_id = var.vnet_id
  ip_address = var.vm02_ip_address
  depends_on = [ azurerm_lb_backend_address_pool.TfAzLbBackendPool ]
}

resource "azurerm_lb_nat_rule" "TfAzLbNATRule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.TfAzLoadBalancer.id
  name                           = "RDPAccess"
  protocol                       = "Udp"
  frontend_port_start            = 3000
  frontend_port_end              = 3388
  backend_port                   = 3390
  backend_address_pool_id        = azurerm_lb_backend_address_pool.TfAzLbBackendPool.id
  frontend_ip_configuration_name = azurerm_lb.TfAzLoadBalancer.frontend_ip_configuration[0].name
  

  depends_on = [ azurerm_lb_backend_address_pool.TfAzLbBackendPool ]
}

resource "azurerm_lb_probe" "TfAzLbProbe" {
  loadbalancer_id = azurerm_lb.TfAzLoadBalancer.id
  name            = "ssh-running-probe"
  protocol = "Http"
  request_path = "/"
  port            = 80

  depends_on = [ azurerm_lb.TfAzLoadBalancer ]
}

resource "azurerm_lb_rule" "TfAzLbRule" {
  loadbalancer_id                = azurerm_lb.TfAzLoadBalancer.id
  name                           = "LBRule1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.TfAzLoadBalancer.frontend_ip_configuration[0].name

  depends_on = [ azurerm_lb.TfAzLoadBalancer ]
}