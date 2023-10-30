
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw

  sensitive = true
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "kube_config" {
  description = "Kubernetes config to connect to the cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config
  sensitive   = true
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.main.node_resource_group
}


output "load_balancer_public_ip" {
  description = "The public IP address of the AKS load balancer."
  value       = azurerm_public_ip.load_balancer_pip[0].ip_address
}