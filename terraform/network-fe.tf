resource "azurerm_route_table" "rsi-routetable-fe" {
  name                          = "rsi-rt-fe"
  resource_group_name           = azurerm_resource_group.rsi.name
  location                      = var.location
  disable_bgp_route_propagation = false

  tags = merge(
    local.default_tags,
    tomap(
      "Component", "Frontend"
  ))
}

module "rsi-fe" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  vnet_location       = var.location

  use_for_each    = true
  address_space   = [local.vnet_address_prefixes["rsi-fe"]]
  subnet_prefixes = [local.subnet_addresses["public"], local.subnet_addresses["frontend"]]
  subnet_names    = ["public", "frontend"]

  nsg_ids = {
    public   = module.nsg-public.network_security_group_id
    frontend = module.nsg-fe.network_security_group_id
  }

  route_tables_ids = {
    public   = azurerm_route_table.rsi-routetable-fe.id
    frontend = azurerm_route_table.rsi-routetable-fe.id
  }

  tags = merge(
    local.default_tags,
    tomap(
      "Component", "Frontend"
  ))
}


module "fe-loadbalancer" {
  source  = "Azure/loadbalancer/azurerm"
  version = "4.4.0"

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location
  name                = "fe-lb"
  type                = "public"
  frontend_subnet_id  = module.rsi-fe.vnet_subnets[0]
  lb_sku              = "Standard"
  pip_sku             = "Standard"
  pip_name            = "fe-lb-pip"

  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }

  tags = merge(
    local.default_tags,
    tomap(
      "Component", "Frontend"
  ))

  depends_on = [
    azurerm_resource_group.rsi,
    module.rsi-fe
  ]
}