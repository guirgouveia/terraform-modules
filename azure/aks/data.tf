data "azurerm_resource_group" "nodes_rg" {
  name       = azurerm_kubernetes_cluster.main.node_resource_group
  depends_on = [azurerm_kubernetes_cluster.main]
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
