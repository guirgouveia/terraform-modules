output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.main.address_space
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.main.id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.main.location
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.main.name
}

output "vnet_subnets_ids" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = values(azurerm_subnet.main)[*].id
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.network.vnet_subnets_name_id, subnet2)"
  value       = zipmap(keys(azurerm_subnet.main), values(azurerm_subnet.main)[*].id)
}

output "vnet_peerings" {
  value = data.azurerm_resources.octopus_tentacles_vnets
}
