data "azurerm_key_vault" "sqlhstkv" {
  count = var.enable_backup ? (var.kv_enable ? 1 : 0) : 0

  name                = var.kv_name
  resource_group_name = var.kv_rg
}

data "azurerm_key_vault_secret" "sqlhstsvc" {
  count = var.enable_backup ? (var.kv_enable ? 1 : 0) : 0

  name         = "sqlhstsvc"
  key_vault_id = data.azurerm_key_vault.sqlhstkv[count.index].id
}

data "azurerm_key_vault_secret" "storageaccountname" {
  count = var.enable_backup ? (var.kv_enable ? 1 : 0) : 0

  name         = "storageaccountname"
  key_vault_id = data.azurerm_key_vault.sqlhstkv[count.index].id
}

data "azurerm_storage_account" "storageaccountinfo" {
  count = var.enable_backup ? 1 : 0

  name                = var.storage_account_name == "" ? data.azurerm_key_vault_secret.storageaccountname[count.index].value : var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_storage_container" "containerinfo" {
  count = var.enable_backup ? 1 : 0

  name                 = var.storage_container_name
  storage_account_name = data.azurerm_storage_account.storageaccountinfo[count.index].name
}
