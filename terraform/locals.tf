locals {

  default_tags = merge(
    var.tags,
    tomap({
      "Terraform" = "true",
      "Region"    = var.location
    })
  )

  vnet_address_prefixes = {
    rsi-fe = "10.0.0.0/16",
    rsi-be = "10.1.0.0/16"
  }

  subnet_addresses = {
    frontend     = "10.0.2.0/24",
    azurebastion = "10.0.3.0/24",
    backend      = "10.1.1.0/24"
  }

}