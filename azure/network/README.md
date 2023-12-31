## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_dns_a_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_zone.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_network_security_group.aks_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.aks_allow_internet_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.aks_allow_lb_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.aks_allow_vnet_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.aks_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.aks_in](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.aks_node_rg_to_tentacles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.aks_out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.octopus_tentacles_in](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.octopus_tentacles_out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.octopus_tentacles_to_aks_node_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_resources.aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |
| [azurerm_resources.octopus_tentacles_vnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_aks_vnet_name"></a> [aks\_vnet\_name](#input\_aks\_vnet\_name) | The name of the vNet to peer with. | `string` | `null` | no |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | (Optional) The BGP community attribute in format `<as-number>:<community-value>`. | `string` | `null` | no |
| <a name="input_create_api_gw"></a> [create\_api\_gw](#input\_create\_api\_gw) | n/a | `bool` | `false` | no |
| <a name="input_create_network_security_group"></a> [create\_network\_security\_group](#input\_create\_network\_security\_group) | n/a | `bool` | `true` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | The set of DDoS protection plan configuration | <pre>object({<br>    enable = bool<br>    id     = string<br>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | The DNS servers to be used with vNet. | `list(string)` | `[]` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | The DNS zone name | `string` | n/a | yes |
| <a name="input_dns_zone_record"></a> [dns\_zone\_record](#input\_dns\_zone\_record) | The DNS zone name | `string` | `"octopus"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the vnet to create. | `string` | n/a | yes |
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | List of security groups for each subnet. | <pre>map(object({<br>    name        = optional(string)<br>    subnet_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids) | A map of subnet name to Network Security Group IDs | `map(string)` | `{}` | no |
| <a name="input_octopus_load_balancer"></a> [octopus\_load\_balancer](#input\_octopus\_load\_balancer) | n/a | `map(string)` | `{}` | no |
| <a name="input_octopus_tentacles_vnet_peering_names"></a> [octopus\_tentacles\_vnet\_peering\_names](#input\_octopus\_tentacles\_vnet\_peering\_names) | n/a | `string` | `"octopus-peering"` | no |
| <a name="input_octopus_tentacles_vnet_peering_tags"></a> [octopus\_tentacles\_vnet\_peering\_tags](#input\_octopus\_tentacles\_vnet\_peering\_tags) | Tags used to identify VNets to be peered. | `map(string)` | <pre>{<br>  "octopus_managed": true<br>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be appended to the names of the resources. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to be imported. | `string` | n/a | yes |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | A map of subnet name to Route table | `map(string)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of subnets containing its attributes such as service delegation, prefixes, private endpoints and private links. | <pre>map(object({<br>    prefixes                                      = list(string)<br>    private_endpoint_network_policies_enabled     = optional(bool)<br>    private_link_service_network_policies_enabled = optional(bool)<br>    service_delegation = optional(list(object({<br>      name    = string<br>      actions = optional(list(string))<br>    })))<br>    service_endpoints = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_subnets_name_id"></a> [subnets\_name\_id](#input\_subnets\_name\_id) | A map of subnet name to subnet ID | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with your network and subnets. | `map(string)` | <pre>{<br>  "ENV": "test"<br>}</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the vnet to create | `string` | `"acctvnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the newly created vNet |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location) | The location of the newly created vNet |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The Name of the newly created vNet |
| <a name="output_vnet_peerings"></a> [vnet\_peerings](#output\_vnet\_peerings) | n/a |
| <a name="output_vnet_subnets_ids"></a> [vnet\_subnets\_ids](#output\_vnet\_subnets\_ids) | The ids of subnets created inside the newly created vNet |
| <a name="output_vnet_subnets_name_id"></a> [vnet\_subnets\_name\_id](#output\_vnet\_subnets\_name\_id) | Can be queried subnet-id by subnet name by using lookup(module.network.vnet\_subnets\_name\_id, subnet2) |
