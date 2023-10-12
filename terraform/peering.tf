resource "azurerm_virtual_network_peering" "rsi-fe-to-be" {
  name                      = "feTobe"
  resource_group_name       = azurerm_resource_group.rsi.name
  virtual_network_name      = module.rsi-fe.vnet_id
  remote_virtual_network_id = module.rsi-be.vnet_id

  triggers = {
    remote_address_space = join(",", module.rsi-be.vnet_address_space)
  }
}

resource "azurerm_virtual_network_peering" "rsi-be-to-fe" {
  name                      = "beTofe"
  resource_group_name       = azurerm_resource_group.rsi.name
  virtual_network_name      = module.rsi-be.vnet_id
  remote_virtual_network_id = module.rsi-fe.vnet_id

  triggers = {
    remote_address_space = join(",", module.rsi-fe.vnet_address_space)
  }
}