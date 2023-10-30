locals {
  administrator_login_password = var.active_directory_administrator_login_username == null ? length(data.azurerm_key_vault_secret.sqlhstsvc) > 0 ? data.azurerm_key_vault_secret.sqlhstsvc[0].value : (var.administrator_login_password != null ? var.administrator_login_password : random_password.main.result) : null
  administrator_login          = var.active_directory_administrator_login_username == null ? var.administrator_login : null
}
