## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.59.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_firewall_rule.mssql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_server_security_alert_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy) | resource |
| [azurerm_mssql_server_vulnerability_assessment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_vulnerability_assessment) | resource |
| [azurerm_mssql_virtual_network_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_key_vault.sqlhstkv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.sqlhstsvc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.storageaccountname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_storage_account.storageaccountinfo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.containerinfo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_administrator_login_username"></a> [active\_directory\_administrator\_login\_username](#input\_active\_directory\_administrator\_login\_username) | The Active Directory Administrator Login Username | `any` | `null` | no |
| <a name="input_active_directory_administrator_object_id"></a> [active\_directory\_administrator\_object\_id](#input\_active\_directory\_administrator\_object\_id) | The Active Directory Administrator Object ID | `any` | `null` | no |
| <a name="input_active_directory_administrator_tenant_id"></a> [active\_directory\_administrator\_tenant\_id](#input\_active\_directory\_administrator\_tenant\_id) | The Active Directory Administrator Tenant ID | `any` | `null` | no |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | (Required) The Administrator Login for the MSSQL Server | `any` | `null` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | (Required) The Password associated with the administrator\_login for the PostgreSQL Server. | `any` | `null` | no |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | (Optional) Specifies whether Azure Active Directory only authentication is enabled on the MSSQL Server. Defaults to false. | `bool` | `false` | no |
| <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy) | The connection policy the server will use (Default, Proxy or Redirect) | `string` | `"Default"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | List of databases to create | `list(string)` | `[]` | no |
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses that should recieve the security reports | `list(string)` | `[]` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | Enable Database backups to Storage ACcount | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment used for keyvault access | `any` | n/a | yes |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | Specifies the Start IP Address associated with main Firewall Rule | `list(string)` | n/a | yes |
| <a name="input_kv_enable"></a> [kv\_enable](#input\_kv\_enable) | (Optional) Enable Key Vault for passwords. | `bool` | `false` | no |
| <a name="input_kv_name"></a> [kv\_name](#input\_kv\_name) | The keyvault name | `string` | `""` | no |
| <a name="input_kv_rg"></a> [kv\_rg](#input\_kv\_rg) | The keyvault resource group | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists | `string` | `"canadacentral"` | no |
| <a name="input_mssql_version"></a> [mssql\_version](#input\_mssql\_version) | The version of the MSSQL Server | `string` | `"12.0"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the MSSQL Server | `any` | n/a | yes |
| <a name="input_primary_mi_id"></a> [primary\_mi\_id](#input\_primary\_mi\_id) | (Optional) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. | `any` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | (Optional) Specifies the list of Private DNS Zones to include within the private\_dns\_zone\_group | `any` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | (Optional) Options to enable private endpoint | `any` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. Defaults to false. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the MSSQL Server | `any` | n/a | yes |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Specifies the retention in days for logs for main MSSQL Server | `number` | `90` | no |
| <a name="input_ssl_minimal_tls_version_enforced"></a> [ssl\_minimal\_tls\_version\_enforced](#input\_ssl\_minimal\_tls\_version\_enforced) | The mimimun TLS version to support on the sever | `string` | `"1.2"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The storage account used for backup. | `string` | `""` | no |
| <a name="input_storage_account_resource_group_name"></a> [storage\_account\_resource\_group\_name](#input\_storage\_account\_resource\_group\_name) | The storage account resource group used for backup. | `string` | `""` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | The storage container id | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet ids to create the private endpoint connection and network rules to the MSSQL Server | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to main Virtual Machine | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assessment_id"></a> [assessment\_id](#output\_assessment\_id) | n/a |
| <a name="output_databases_connection_strings"></a> [databases\_connection\_strings](#output\_databases\_connection\_strings) | The connection strings to the databases by name. |
| <a name="output_firewall"></a> [firewall](#output\_firewall) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_sa_primary_access_key"></a> [sa\_primary\_access\_key](#output\_sa\_primary\_access\_key) | n/a |
| <a name="output_sa_primary_blob_endpoint"></a> [sa\_primary\_blob\_endpoint](#output\_sa\_primary\_blob\_endpoint) | n/a |
