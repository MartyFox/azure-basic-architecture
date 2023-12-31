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
  subnet_prefixes = [local.subnet_addresses["frontend"], local.subnet_addresses["azurebastion"]]
  subnet_names    = ["frontend", "AzureBastionSubnet"]

  nsg_ids = {
    frontend = module.nsg-fe.network_security_group_id
  }

  route_tables_ids = {
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
    module.nsg-fe
  ]
}


module "fe-loadbalancer" {
  source  = "Azure/loadbalancer/azurerm"
  version = "4.4.0"

  resource_group_name   = azurerm_resource_group.rsi.name
  location              = var.location
  name                  = "rsi-fe-lb"
  lb_sku                = "Standard"
  pip_sku               = "Standard"
  pip_name              = "fe-lb-pip"
  pip_domain_name_label = "rsi-${var.environment}"

  lb_port = {
    http = ["80", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Http", "80", "/"]
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