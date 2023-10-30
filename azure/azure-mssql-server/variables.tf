variable "name" {
  description = "The name of the MSSQL Server"
}

variable "administrator_login" {
  description = "(Required) The Administrator Login for the MSSQL Server"
  default     = null
}

variable "administrator_login_password" {
  description = "(Required) The Password associated with the administrator_login for the PostgreSQL Server."
  default     = null
}

variable "azuread_authentication_only" {
  description = "(Optional) Specifies whether Azure Active Directory only authentication is enabled on the MSSQL Server. Defaults to false."
  type        = bool
  default     = false
}

variable "retention_days" {
  description = "Specifies the retention in days for logs for main MSSQL Server"
  default     = 90
}

variable "mssql_version" {
  description = "The version of the MSSQL Server"
  default     = "12.0"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the MSSQL Server"
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The mimimun TLS version to support on the sever"
  default     = "1.2"
}

variable "connection_policy" {
  description = "The connection policy the server will use (Default, Proxy or Redirect)"
  default     = "Default"
}

variable "environment" {
  description = "The environment used for keyvault access"
}

variable "firewall_rules" {
  type        = list(string)
  description = "Specifies the Start IP Address associated with main Firewall Rule"
}

variable "subnets" {
  description = "List of subnet ids to create the private endpoint connection and network rules to the MSSQL Server"
  default     = []
}

variable "active_directory_administrator_login_username" {
  description = "The Active Directory Administrator Login Username"
  default     = null
}

variable "active_directory_administrator_object_id" {
  description = "The Active Directory Administrator Object ID"
  default     = null
}

variable "active_directory_administrator_tenant_id" {
  description = "The Active Directory Administrator Tenant ID"
  default     = null
}

variable "emails" {
  type        = list(string)
  description = "List of email addresses that should recieve the security reports"
  default     = []
}

variable "kv_name" {
  description = "The keyvault name"
  default     = ""
}

variable "kv_rg" {
  description = "The keyvault resource group"
  default     = ""
}

variable "storage_account_resource_group_name" {
  description = "The storage account resource group used for backup."
  default     = ""
}

variable "storage_account_name" {
  description = "The storage account used for backup."
  default     = ""
}

variable "kv_enable" {
  description = "(Optional) Enable Key Vault for passwords."
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "(Optional) Options to enable private endpoint"
  default     = null
}

variable "private_dns_zone_ids" {
  description = "(Optional) Specifies the list of Private DNS Zones to include within the private_dns_zone_group"
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to main Virtual Machine"
  type        = map(string)
  default     = null
}

variable "primary_mi_id" {
  description = "(Optional) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to."
  default     = null
}

variable "enable_backup" {
  description = "Enable Database backups to Storage ACcount"
  default     = false
}

variable "storage_container_name" {
  description = "The storage container id"
  default     = ""
}

variable "databases" {
  description = "List of databases to create"
  type        = list(string)
  default     = []
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this server. Defaults to false."
  default     = true
}
