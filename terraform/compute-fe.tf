data "cloudinit_config" "vmss-fe-config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloudconfig.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/cloudconfig.yaml")
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "rsi-frontend-vmss" {

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location

  name                 = "rsi-vmss-fe"
  computer_name_prefix = "rsi-vm-fe-"

  sku                             = var.fe_instance_type
  instances                       = var.fe_instance_count
  admin_username                  = "azureuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data                     = data.cloudinit_config.vmss-fe-config.rendered

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "rsi-fe-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = lookup(module.rsi-vnet-fe.vnet_subnets_name_id, "frontend")
      load_balancer_backend_address_pool_ids = module.fe-loadbalancer.azurerm_lb_backend_address_pool_id
    }
  }
}