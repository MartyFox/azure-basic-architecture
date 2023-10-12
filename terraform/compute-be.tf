# resource "azurerm_linux_virtual_machine" "backend" {
#   resource_group_name                    = azurerm_resource_group.rsi.name
#   location                               = var.location

#   name                = "rsi-vm-backend"
#   size                = "Standard_F2s_v2"
#   admin_username      = "adminuser"

#   network_interface_ids = [
#     azurerm_network_interface.backend.id,
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/azure-simple-arch.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "22_04-lts" 
#     version   = "latest"
#   }

#   tags = merge(
#       local.default_tags,
#       tomap({
#       "Component" = "Backend"
#       })
#   )
# }

# resource "azurerm_network_interface" "backend" {
#   resource_group_name                    = azurerm_resource_group.rsi.name
#   location                               = var.location

#   name                = "rsi-vm-be-nic"

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = lookup(module.rsi-vnet-fe.vnet_subnets_name_id, "backend")
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = merge(
#       local.default_tags,
#       tomap({
#       "Component" = "Backend"
#       })
#   )
# }