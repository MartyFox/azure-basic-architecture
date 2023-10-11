# resource "azurerm_resource_group" "bastion" {
#   name     = "rg-bastion-001"
#   location = var.location
# }

# module "bastion" {
#   source = "../modules/az-bastion"

#   resource_group_name = azurerm_resource_group.bastion.name
#   location            = var.location
#   subnet_id           = module.vnet.vnet_subnets[2] ## AzureBastionSubnet Id selected from list of created subnets, lists start at 0 so 2 = 3rd in list

#   bastion_name  = "bast--001"
#   publicip_name = "pip--bastion-001"
#   nsg_name      = "nsg--bastion-001"

#   tags = merge(
#     local.default_tags,
#     map(
#       "ServiceTeam", "Networks"
#     )
#   )

#   depends_on = [
#     azurerm_resource_group.bastion,
#     module.vnet
#   ]
# }