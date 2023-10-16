# azure-basic-architecture

Simple infrastructure for Azure architecture, includes use of Terraform and Github Actions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >=2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >=2.2.0 |

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
| [azurerm_linux_virtual_machine.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine_scale_set.rsi-frontend-vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_log_analytics_workspace.rsi-law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_interface.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rsi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route_table.rsi-routetable-be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.rsi-routetable-fe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_virtual_network_peering.rsi-be-to-fe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.rsi-fe-to-be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [cloudinit_config.vm-be-config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.vmss-fe-config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_fe_instance_type"></a> [fe\_instance\_type](#input\_fe\_instance\_type) | n/a | `string` | n/a | yes |
| <a name="input_fe_instance_count"></a> [fe\_instance\_count](#input\_fe\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"uk south"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->