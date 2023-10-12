# azure-basic-architecture

Simple infrastructure for Azure architecture, includes use of Terraform and Github Actions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../modules/az-bastion | n/a |
| <a name="module_fe-loadbalancer"></a> [fe-loadbalancer](#module\_fe-loadbalancer) | Azure/loadbalancer/azurerm | 4.4.0 |
| <a name="module_nsg-be"></a> [nsg-be](#module\_nsg-be) | Azure/network-security-group/azurerm | 4.1.0 |
| <a name="module_nsg-fe"></a> [nsg-fe](#module\_nsg-fe) | Azure/network-security-group/azurerm | 4.1.0 |
| <a name="module_rsi-vnet-be"></a> [rsi-vnet-be](#module\_rsi-vnet-be) | Azure/vnet/azurerm | 4.1.0 |
| <a name="module_rsi-vnet-fe"></a> [rsi-vnet-fe](#module\_rsi-vnet-fe) | Azure/vnet/azurerm | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rsi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route_table.rsi-routetable-be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.rsi-routetable-fe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_virtual_network_peering.rsi-be-to-fe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.rsi-fe-to-be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"uk south"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fe-subnets"></a> [fe-subnets](#output\_fe-subnets) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->