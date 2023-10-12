resource "azurerm_virtual_network_peering" "rsi-fe-to-be" {
  name                      = "feTobe"
  resource_group_name       = azurerm_resource_group.rsi.name
  virtual_network_name      = module.rsi-vnet-fe.vnet_name
  remote_virtual_network_id = module.rsi-vnet-be.vnet_id

  triggers = {
    remote_address_space = join(",", module.rsi-vnet-be.vnet_address_space)
  }

  depends_on = [
    module.rsi-vnet-fe,
    module.rsi-vnet-be,
  ]
}

resource "azurerm_virtual_network_peering" "rsi-be-to-fe" {
  name                      = "beTofe"
  resource_group_name       = azurerm_resource_group.rsi.name
  virtual_network_name      = module.rsi-vnet-be.vnet_name
  remote_virtual_network_id = module.rsi-vnet-fe.vnet_id

  triggers = {
    remote_address_space = join(",", module.rsi-vnet-fe.vnet_address_space)
  }

  depends_on = [
    module.rsi-vnet-fe,
    module.rsi-vnet-be,
  ]
}