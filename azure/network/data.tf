########################################################################
# Peer the VNet created by this module with the Octopus Tentacles VNets
########################################################################
data "azurerm_resources" "octopus_tentacles_vnets" {
  type = "Microsoft.Network/virtualNetworks"

  required_tags = var.octopus_tentacles_vnet_peering_tags
}

resource "azurerm_virtual_network_peering" "octopus_tentacles_in" {
  count = length(data.azurerm_resources.octopus_tentacles_vnets.resources)

  name                      = format("vnet-peering-%s-to-%s", azurerm_virtual_network.main.name, "${data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name}")
  resource_group_name       = split("/", data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].id)[4]
  virtual_network_name      = data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name
  remote_virtual_network_id = azurerm_virtual_network.main.id
}

resource "azurerm_virtual_network_peering" "octopus_tentacles_out" {
  count = length(data.azurerm_resources.octopus_tentacles_vnets.resources)

  name                      = format("vnet-peering-%s-to-%s", "${data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name}", azurerm_virtual_network.main.name)
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.main.name
  remote_virtual_network_id = data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].id
}


########################################################################
# Peer the AKS Node Resource Group VNets with this virtual network 
########################################################################
data "azurerm_resources" "aks_vnet" {
  type = "Microsoft.Network/virtualNetworks"

  required_tags = merge(var.tags, { resource = "aks-octopus" })
}

resource "azurerm_virtual_network_peering" "aks_in" {
  count = length(data.azurerm_resources.aks_vnet.resources) > 0 ? 1 : 0

  name                      = format("vnet-peering-%s-to-%s", data.azurerm_resources.aks_vnet.resources[0].name, azurerm_virtual_network.main.name)
  resource_group_name       = split("/", data.azurerm_resources.aks_vnet.resources[0].id)[4]
  virtual_network_name      = data.azurerm_resources.aks_vnet.resources[0].name
  remote_virtual_network_id = azurerm_virtual_network.main.id
}

resource "azurerm_virtual_network_peering" "aks_out" {
  count = length(data.azurerm_resources.octopus_tentacles_vnets.resources) > 0 ? 1 : 0

  name                      = format("vnet-peering-%s-to-%s", azurerm_virtual_network.main.name, data.azurerm_resources.aks_vnet.resources[0].name)
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.main.name
  remote_virtual_network_id = data.azurerm_resources.aks_vnet.resources[0].id
}

########################################################################
# Peer the AKS Node Resource Group VNets with  the octopus vnets
########################################################################
resource "azurerm_virtual_network_peering" "aks_node_rg_to_tentacles" {
  count = length(data.azurerm_resources.octopus_tentacles_vnets.resources) > 0 ? length(data.azurerm_resources.octopus_tentacles_vnets.resources) : 0

  name                      = format("vnet-peering-%s-to-%s", data.azurerm_resources.aks_vnet.resources[0].name, data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name)
  resource_group_name       = split("/", data.azurerm_resources.aks_vnet.resources[0].id)[4]
  virtual_network_name      = data.azurerm_resources.aks_vnet.resources[0].name
  remote_virtual_network_id = data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].id
}

resource "azurerm_virtual_network_peering" "octopus_tentacles_to_aks_node_rg" {
  count = length(data.azurerm_resources.octopus_tentacles_vnets.resources) > 0 ? length(data.azurerm_resources.octopus_tentacles_vnets.resources) : 0

  name                      = format("vnet-peering-%s-to-%s", data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name, data.azurerm_resources.aks_vnet.resources[0].name)
  resource_group_name       = split("/", data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].id)[4]
  virtual_network_name      = data.azurerm_resources.octopus_tentacles_vnets.resources[count.index].name
  remote_virtual_network_id = data.azurerm_resources.aks_vnet.resources[0].id
}
