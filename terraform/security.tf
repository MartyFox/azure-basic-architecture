#tfsec:ignore:azure-network-no-public-ingress
module "nsg-public" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location

  security_group_name   = "rsi-nsg-public"
  source_address_prefix = ["*"]
  predefined_rules = [
    {
      name     = "HTTP"
      priority = 101
    },
    {
      name     = "HTTPS"
      priority = 201
    }
  ]

  custom_rules = [
    {
      name                   = "DENY"
      priority               = "4096"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "Tcp"
      destination_port_range = "*"
      description            = "default-deny"
    }
  ]

  tags = merge(
    local.default_tags,
    tomap({
      "Component" = "Frontend",
      "Public"    = "true"
    })
  )

  depends_on = [azurerm_resource_group.rsi]
}

module "nsg-fe" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rsi.name
  location            = var.location

  security_group_name = "rsi-nsg-frontend"

  custom_rules = [
    {
      name                   = "AzureLoadBalancer"
      priority               = "101"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "*"
      source_address_prefix  = "AzureLoadBalancer"
      description            = "AzureLoadBalancerAllowed"
    },
    {
      name                   = "DENY"
      priority               = "4096"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "Tcp"
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
      name                   = "SSH-FE"
      priority               = "101"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "22"
      source_address_prefix  = local.subnet_addresses["frontend"]
      description            = "FrontendAllowSSH"
    },
    {
      name                   = "ICMP-FE"
      priority               = "102"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Icmp"
      destination_port_range = "*"
      source_address_prefix  = local.subnet_addresses["frontend"]
      description            = "FrontendAllowSSH"
    },
    {
      name                   = "MySQL-DB-FE"
      priority               = "201"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      destination_port_range = "3306"
      source_address_prefix  = local.subnet_addresses["frontend"]
      description            = "FrontendAllowMySQL"
    },
    {
      name                   = "DENY"
      priority               = "4096"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "Tcp"
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