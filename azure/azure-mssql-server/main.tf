# Based on https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v2.0.1

resource "random_password" "main" {
  length           = 16
  upper            = true
  lower            = true
  numeric          = true
  min_upper        = 4
  min_lower        = 2
  min_numeric      = 4
  special          = true
  override_special = "_@%#"

  keepers = {
    administrator_login_password = var.name
  }
}

resource "azurerm_mssql_server" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = local.administrator_login
  administrator_login_password = local.administrator_login_password
  version                      = var.mssql_version

  minimum_tls_version = var.ssl_minimal_tls_version_enforced

  connection_policy = var.connection_policy

  dynamic "azuread_administrator" {
    for_each = var.active_directory_administrator_login_username == null ? [] : ["azuread_administrator"]

    content {
      azuread_authentication_only = var.azuread_authentication_only

      login_username = var.active_directory_administrator_login_username
      object_id      = var.active_directory_administrator_object_id
      tenant_id      = var.active_directory_administrator_tenant_id
    }
  }

  identity {
    type         = var.primary_mi_id == null ? "SystemAssigned" : "UserAssigned"
    identity_ids = var.primary_mi_id == null ? [] : [var.primary_mi_id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "main" {
  for_each = toset(var.databases)

  name                 = each.value
  storage_account_type = "Local"
  server_id            = azurerm_mssql_server.main.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  license_type         = null
  max_size_gb          = 250
  read_scale           = false
  sku_name             = "S1"
  zone_redundant       = false

  tags = var.tags
}


resource "azurerm_role_assignment" "main" {
  count = var.enable_backup ? (var.kv_enable ? 0 : 1) : 0

  description          = "${azurerm_mssql_server.main.name}-ra"
  scope                = data.azurerm_storage_account.storageaccountinfo[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.primary_mi_id == null ? azurerm_mssql_server.main.identity.0.principal_id : var.primary_mi_id

  depends_on = [
    azurerm_mssql_server.main,
    azurerm_mssql_firewall_rule.mssql
  ]
}


resource "azurerm_mssql_firewall_rule" "mssql" {
  count = var.firewall_rules == null ? 0 : length(var.firewall_rules)

  name             = azurerm_mssql_server.main.name
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = var.firewall_rules[count.index]
  end_ip_address   = var.firewall_rules[count.index]
}

resource "azurerm_mssql_virtual_network_rule" "main" {
  count = length(var.subnets)

  name      = split("/", var.subnets[count.index])[10]
  server_id = azurerm_mssql_server.main.id
  subnet_id = var.subnets[count.index]
}


resource "azurerm_mssql_server_security_alert_policy" "main" {
  server_name         = azurerm_mssql_server.main.name
  resource_group_name = var.resource_group_name

  storage_endpoint           = var.enable_backup ? (var.kv_enable ? null : data.azurerm_storage_account.storageaccountinfo[0].primary_blob_endpoint) : null
  storage_account_access_key = var.enable_backup ? (var.kv_enable ? null : data.azurerm_storage_account.storageaccountinfo[0].primary_access_key) : null

  state          = "Enabled"
  retention_days = var.retention_days

  email_addresses = var.emails

  depends_on = [
    azurerm_role_assignment.main
  ]
}

resource "azurerm_mssql_server_extended_auditing_policy" "main" {
  server_id = azurerm_mssql_server.main.id

  storage_endpoint           = var.enable_backup ? (var.kv_enable ? data.azurerm_storage_account.storageaccountinfo[0].primary_blob_endpoint : data.azurerm_storage_account.storageaccountinfo[0].primary_blob_endpoint) : null
  storage_account_access_key = var.enable_backup ? (var.kv_enable ? null : data.azurerm_storage_account.storageaccountinfo[0].primary_access_key) : null

  retention_in_days      = var.retention_days
  log_monitoring_enabled = true

  depends_on = [
    azurerm_role_assignment.main,
    azurerm_mssql_server_security_alert_policy.main
  ]
}

resource "azurerm_mssql_server_vulnerability_assessment" "main" {
  count = var.enable_backup ? 1 : 0

  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.main.id

  storage_container_path     = var.enable_backup ? (var.kv_enable ? "${data.azurerm_storage_account.storageaccountinfo[0].primary_blob_endpoint}vulnerability-assessment/" : "${data.azurerm_storage_account.storageaccountinfo[0].primary_blob_endpoint}${data.azurerm_storage_container.containerinfo[0].name}/") : null
  storage_account_access_key = var.enable_backup ? (var.kv_enable ? null : data.azurerm_storage_account.storageaccountinfo[0].primary_access_key) : null

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = var.emails
  }

  depends_on = [
    azurerm_role_assignment.main,
    azurerm_mssql_server_security_alert_policy.main
  ]

}

resource "azurerm_private_endpoint" "main" {
  count = var.private_endpoint_subnet_id == null ? 0 : 1

  name                = "${var.name}-${var.environment}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-${var.environment}-pl"
    private_connection_resource_id = azurerm_mssql_server.main.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
  tags = var.tags
}
