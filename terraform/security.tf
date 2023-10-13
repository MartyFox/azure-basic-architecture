module "nsg-fe" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location

  security_group_name = "rsi-nsg-frontend"

  custom_rules = [
    {
      name                         = "VirtualNetwork"
      priority                     = "101"
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "*"
      destination_port_range       = "*"
      source_address_prefixes      = [local.vnet_address_prefixes["rsi-fe"]]
      destination_address_prefixes = [local.vnet_address_prefixes["rsi-fe"]]
      description                  = "Allow Local Networks"
    },
    {
      name                   = "AzureLoadBalancer"
      priority               = "201"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "*"
      destination_port_range = "*"
      source_address_prefix  = "AzureLoadBalancer"
      description            = "AzureLoadBalancerAllowed"
    },
    {
      name                   = "DENY"
      priority               = "4096"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "*"
      destination_port_range = "*"
      description            = "default-deny"
    }
  ]

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Frontend",
    })
  )

  depends_on = [azurerm_resource_group.rsi]
}

module "nsg-be" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location

  security_group_name = "rsi-nsg-backend"

  custom_rules = [
    {
      name                         = "VirtualNetwork"
      priority                     = "101"
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "*"
      destination_port_range       = "*"
      source_address_prefixes      = [local.vnet_address_prefixes["rsi-be"]]
      destination_address_prefixes = [local.vnet_address_prefixes["rsi-be"]]
      description                  = "Allow Local Networks"
    },
    {
      name                   = "SSH-FE"
      priority               = "201"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "22"
      source_address_prefix  = local.vnet_address_prefixes["rsi-fe"]
      description            = "FrontendAllowSSH"
    },
    {
      name                   = "ICMP-FE"
      priority               = "202"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Icmp"
      destination_port_range = "*"
      source_address_prefix  = local.subnet_addresses["frontend"]
      description            = "FrontendAllowSSH"
    },
    {
      name                   = "MySQL-DB-FE"
      priority               = "301"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "3306"
      source_address_prefix  = local.subnet_addresses["frontend"]
      description            = "FrontendAllowMySQL"
    },
    {
      name                   = "DENY"
      priority               = "4096"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "*"
      destination_port_range = "*"
      description            = "default-deny"
    }
  ]

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Backend",
    })
  )

  depends_on = [azurerm_resource_group.rsi]

}