resource "azurerm_route_table" "rsi-routetable-be" {
  name                          = "rsi-rt-be"
  resource_group_name           = azurerm_resource_group.rsi.name
  location                      = var.location
  disable_bgp_route_propagation = false

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Backend"
  }))
}

module "rsi-vnet-be" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  vnet_location       = var.location
  vnet_name           = "rsi-be-vnet"

  use_for_each    = true
  address_space   = [local.vnet_address_prefixes["rsi-be"]]
  subnet_prefixes = [local.subnet_addresses["backend"]]
  subnet_names    = ["backend"]

  nsg_ids = {
    backend = module.nsg-be.network_security_group_id
  }

  route_tables_ids = {
    backend = azurerm_route_table.rsi-routetable-be.id
  }

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Backend"
  }))

  depends_on = [
    azurerm_route_table.rsi-routetable-be,
    module.nsg-be
  ]
}

