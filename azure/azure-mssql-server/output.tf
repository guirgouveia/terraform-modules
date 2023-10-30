output "id" {
  value = azurerm_mssql_server.main.id
}

output "name" {
  value = azurerm_mssql_server.main.name
}

# output "identity_tenant_id" {
#   value = azurerm_mssql_server.main.identity[0].tenant_id
# }

# output "identity_object_id" {
#   value = azurerm_mssql_server.main.identity[0].principal_id
# }

output "sa_primary_blob_endpoint" {
  value = azurerm_mssql_server_extended_auditing_policy.main.storage_endpoint
}

output "sa_primary_access_key" {
  value = var.enable_backup ? null : azurerm_mssql_server_extended_auditing_policy.main.storage_account_access_key
}

output "assessment_id" {
  value = azurerm_mssql_server_vulnerability_assessment.main[*].id
}

output "firewall" {
  value = azurerm_mssql_firewall_rule.mssql
}

output "databases_connection_strings" {
  value       = { for db in azurerm_mssql_database.main : db.name => "Server=tcp:${azurerm_mssql_server.main.name}.database.windows.net,1433;Initial Catalog=${db.name};Persist Security Info=False;User ID=devops;Password=${local.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" }
  description = "The connection strings to the databases by name."
  sensitive   = true
}

output "administrator_login" {
  description = "The administrator login name for the server."
  value       = local.administrator_login
  sensitive   = true
}

output "administrator_login_password" {
  description = "Password to authenticate to the server."
  sensitive   = true
  value       = local.administrator_login_password
}
