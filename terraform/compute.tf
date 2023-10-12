# module "vmss-fe" {
#   source                = "Azure/vmss-cloudinit/azurerm"
#   version               = "1.1.0"

#   resource_group_name   = azurerm_resource_group.rsi.name
#   location              = var.location

#   vnet_subnet_id        = module.rsi-vnet-fe.vnet_subnets[1]
#   vm_size               = "Standard_D2a_v4"
#   cloudconfig_file      = "${path.module}/cloudconfig.tpl"
#   admin_username        = "azureuser"
#   admin_password        = var.admin_password
#   ssh_key               = file("~/.ssh/azure-simple-arch.pub")
#   nb_instance           = 2
#   vm_os_simple          = "UbuntuServer"
#   computer_name_prefix  = "rsi-vm-fe-"

#   load_balancer_backend_address_pool_ids = module.fe-loadbalancer.azurerm_lb_backend_address_pool_id

#   tags = merge(
#           local.default_tags,
#           tomap(
#           "Component", "Frontend"
#       ))
# }

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
#     subnet_id                     = module.rsi-vnet-be.vnet_subnets[0]
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = merge(
#       local.default_tags,
#       tomap({
#       "Component" = "Backend"
#       })
#   )
# }