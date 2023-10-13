resource "azurerm_resource_group" "bastion" {
  name     = "rsi-bastion-${var.environment}-rg"
  location = var.location
}

module "bastion" {
  source = "../modules/az-bastion"

  resource_group_name = azurerm_resource_group.bastion.name
  location            = var.location
  subnet_id           = lookup(module.rsi-vnet-fe.vnet_subnets_name_id, "AzureBastionSubnet") ## AzureBastionSubnet Id selected from list of created subnets, lists start at 0 so 2 = 3rd in list

  bastion_name  = "rsi-bast"
  publicip_name = "rsi-bastion-pip"
  nsg_name      = "rsi-bastion-nsg"

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Access"
    })
  )

  depends_on = [
    azurerm_resource_group.bastion,
    module.rsi-vnet-fe
  ]

}