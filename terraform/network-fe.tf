resource "azurerm_route_table" "rsi-routetable-fe" {
  name                          = "rsi-rt-fe"
  resource_group_name           = azurerm_resource_group.rsi.name
  location                      = var.location
  disable_bgp_route_propagation = false

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Frontend"
    })
  )
}

module "rsi-vnet-fe" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  vnet_location       = var.location
  vnet_name           = "rsi-fe-vnet"

  use_for_each    = true
  address_space   = [local.vnet_address_prefixes["rsi-fe"]]
  subnet_prefixes = [local.subnet_addresses["public"], local.subnet_addresses["frontend"], local.subnet_addresses["azurebastion"]]
  subnet_names    = ["public", "frontend", "AzureBastionSubnet"]

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
    tomap({
      "Component" = "Frontend"
    })
  )

  depends_on = [
    azurerm_route_table.rsi-routetable-be,
    module.nsg-public,
    module.nsg-fe
  ]
}


module "fe-loadbalancer" {
  source  = "Azure/loadbalancer/azurerm"
  version = "4.4.0"

  resource_group_name                    = azurerm_resource_group.rsi.name
  location                               = var.location
  name                                   = "fe-lb"
  type                                   = "private"
  frontend_subnet_id                     = lookup(module.rsi-vnet-fe.vnet_subnets_name_id, "public")
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = cidrhost(local.subnet_addresses["public"], 10)
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"
  pip_name                               = "fe-lb-pip"

  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Frontend"
    })
  )

  depends_on = [
    azurerm_resource_group.rsi,
    module.rsi-vnet-fe
  ]
}