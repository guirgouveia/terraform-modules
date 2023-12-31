## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.59.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.59.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.extaudit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_mysql_active_directory_administrator.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_active_directory_administrator) | resource |
| [azurerm_mysql_configuration.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_configuration) | resource |
| [azurerm_mysql_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_database) | resource |
| [azurerm_mysql_firewall_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_firewall_rule) | resource |
| [azurerm_mysql_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_server) | resource |
| [azurerm_mysql_server_key.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_server_key) | resource |
| [azurerm_mysql_virtual_network_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_virtual_network_rule) | resource |
| [azurerm_private_dns_a_record.arecord1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.dnszone1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vent-link1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.pep1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storeacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.snet-ep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [random_password.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.str](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.logws](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_endpoint_connection.private-ip1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.vnet01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_admin_login_name"></a> [ad\_admin\_login\_name](#input\_ad\_admin\_login\_name) | The login name of the principal to set as the server administrator | `any` | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password associated with the admin\_username user | `any` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The administrator login name for the new SQL Server | `any` | `null` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default` | `string` | `"Default"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Whether to create resource group and use it for all networking resources | `bool` | `true` | no |
| <a name="input_creation_source_server_id"></a> [creation\_source\_server\_id](#input\_creation\_source\_server\_id) | For creation modes other than `Default`, the source server ID to use. | `any` | `null` | no |
| <a name="input_disabled_alerts"></a> [disabled\_alerts](#input\_disabled\_alerts) | Specifies an array of alerts that are disabled. Allowed values are: Sql\_Injection, Sql\_Injection\_Vulnerability, Access\_Anomaly, Data\_Exfiltration, Unsafe\_Action. | `list(any)` | `[]` | no |
| <a name="input_email_addresses_for_alerts"></a> [email\_addresses\_for\_alerts](#input\_email\_addresses\_for\_alerts) | A list of email addresses which alerts should be sent to. | `list(any)` | `[]` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Manages a Private Endpoint to Azure database for MySQL | `bool` | `false` | no |
| <a name="input_enable_threat_detection_policy"></a> [enable\_threat\_detection\_policy](#input\_enable\_threat\_detection\_policy) | Threat detection policy configuration, known in the API as Server Security Alerts Policy | `bool` | `false` | no |
| <a name="input_existing_private_dns_zone"></a> [existing\_private\_dns\_zone](#input\_existing\_private\_dns\_zone) | Name of the existing private DNS zone | `any` | `null` | no |
| <a name="input_extaudit_diag_logs"></a> [extaudit\_diag\_logs](#input\_extaudit\_diag\_logs) | Database Monitoring Category details for Azure Diagnostic setting | `list` | <pre>[<br>  "MySqlSlowLogs",<br>  "MySqlAuditLogs"<br>]</pre> | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | Range of IP addresses to allow firewall connections. | <pre>map(object({<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | If you want your SQL Server to have an managed identity. Defaults to false. | `bool` | `false` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | The URL to a Key Vault Key | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `""` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of log analytics workspace name | `any` | `null` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Specifies the number of days to keep in the Threat Detection audit logs | `string` | `"30"` | no |
| <a name="input_mysql_configuration"></a> [mysql\_configuration](#input\_mysql\_configuration) | Sets a MySQL Configuration value on a MySQL Server | `map(string)` | `{}` | no |
| <a name="input_mysqlserver_name"></a> [mysqlserver\_name](#input\_mysqlserver\_name) | MySQL server Name | `string` | `""` | no |
| <a name="input_mysqlserver_settings"></a> [mysqlserver\_settings](#input\_mysqlserver\_settings) | MySQL server settings | <pre>object({<br>    sku_name                          = string<br>    version                           = string<br>    storage_mb                        = number<br>    auto_grow_enabled                 = optional(bool)<br>    backup_retention_days             = optional(number)<br>    geo_redundant_backup_enabled      = optional(bool)<br>    infrastructure_encryption_enabled = optional(bool)<br>    public_network_access_enabled     = optional(bool)<br>    ssl_enforcement_enabled           = bool<br>    ssl_minimal_tls_version_enforced  = optional(string)<br>    database_name                     = string<br>    charset                           = string<br>    collation                         = string<br>  })</pre> | n/a | yes |
| <a name="input_private_subnet_address_prefix"></a> [private\_subnet\_address\_prefix](#input\_private\_subnet\_address\_prefix) | The name of the subnet for private endpoints | `any` | `null` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | The desired length of random password created by this module | `number` | `24` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_restore_point_in_time"></a> [restore\_point\_in\_time](#input\_restore\_point\_in\_time) | When `create_mode` is `PointInTimeRestore`, specifies the point in time to restore from `creation_source_server_id` | `any` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account name | `any` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The resource ID of the subnet | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_sql_server_fqdn"></a> [primary\_sql\_server\_fqdn](#output\_primary\_sql\_server\_fqdn) | The fully qualified domain name of the primary Azure SQL Server |
| <a name="output_primary_sql_server_id"></a> [primary\_sql\_server\_id](#output\_primary\_sql\_server\_id) | The primary Microsoft SQL Server ID |
| <a name="output_primary_sql_server_private_endpoint"></a> [primary\_sql\_server\_private\_endpoint](#output\_primary\_sql\_server\_private\_endpoint) | id of the Primary SQL server Private Endpoint |
| <a name="output_primary_sql_server_private_endpoint_fqdn"></a> [primary\_sql\_server\_private\_endpoint\_fqdn](#output\_primary\_sql\_server\_private\_endpoint\_fqdn) | Priamary SQL server private endpoint IPv4 Addresses |
| <a name="output_primary_sql_server_private_endpoint_ip"></a> [primary\_sql\_server\_private\_endpoint\_ip](#output\_primary\_sql\_server\_private\_endpoint\_ip) | Priamary SQL server private endpoint IPv4 Addresses |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | The location of the resource group in which resources are created |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group in which resources are created |
| <a name="output_secondary_sql_server_fqdn"></a> [secondary\_sql\_server\_fqdn](#output\_secondary\_sql\_server\_fqdn) | The fully qualified domain name of the secondary Azure SQL Server |
| <a name="output_secondary_sql_server_id"></a> [secondary\_sql\_server\_id](#output\_secondary\_sql\_server\_id) | The secondary Microsoft SQL Server ID |
| <a name="output_secondary_sql_server_private_endpoint"></a> [secondary\_sql\_server\_private\_endpoint](#output\_secondary\_sql\_server\_private\_endpoint) | id of the Primary SQL server Private Endpoint |
| <a name="output_secondary_sql_server_private_endpoint_fqdn"></a> [secondary\_sql\_server\_private\_endpoint\_fqdn](#output\_secondary\_sql\_server\_private\_endpoint\_fqdn) | Secondary SQL server private endpoint IPv4 Addresses |
| <a name="output_secondary_sql_server_private_endpoint_ip"></a> [secondary\_sql\_server\_private\_endpoint\_ip](#output\_secondary\_sql\_server\_private\_endpoint\_ip) | Secondary SQL server private endpoint IPv4 Addresses |
| <a name="output_sql_database_id"></a> [sql\_database\_id](#output\_sql\_database\_id) | The SQL Database ID |
| <a name="output_sql_database_name"></a> [sql\_database\_name](#output\_sql\_database\_name) | The SQL Database Name |
| <a name="output_sql_failover_group_id"></a> [sql\_failover\_group\_id](#output\_sql\_failover\_group\_id) | A failover group of databases on a collection of Azure SQL servers. |
| <a name="output_sql_server_admin_password"></a> [sql\_server\_admin\_password](#output\_sql\_server\_admin\_password) | SQL database administrator login password |
| <a name="output_sql_server_admin_user"></a> [sql\_server\_admin\_user](#output\_sql\_server\_admin\_user) | SQL database administrator login id |
| <a name="output_sql_server_private_dns_zone_domain"></a> [sql\_server\_private\_dns\_zone\_domain](#output\_sql\_server\_private\_dns\_zone\_domain) | DNS zone name of SQL server Private endpoints dns name records |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
