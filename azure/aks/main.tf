# ----------------------
# Local Values
# ----------------------
locals {
  # Common values
  resource_group = {
    name     = var.create_resource_group ? azurerm_resource_group.main[0].name : var.resource_group_name
    location = var.location
  }
  acr_name           = coalesce(var.acr_name, "${replace(var.prefix, "-", "")}acr")
  aks_name           = coalesce(var.cluster_name, "${var.prefix}-aks")
  aks_public_ip_name = coalesce(var.cluster_name, "${var.prefix}-pip")

  dns_prefix              = coalesce(var.dns_prefix, local.aks_name, random_string.dns_prefix.result)
  log_analytics_workspace = coalesce(var.log_analytics_workspace_name, "${var.prefix}-aks-log-analytics")

  # Derived values
  node_labels_linux   = { "os" = "Linux" }
  node_labels_windows = { "os" = "Windows" }
}

# ----------------------
# Resource Group
# ----------------------
resource "azurerm_resource_group" "main" {
  count = var.create_resource_group ? 1 : 0

  location = var.location
  name     = coalesce(var.resource_group_name, var.prefix)
  tags     = var.tags
}

# ----------------------
# Random DNS Prefix
# ----------------------
resource "random_string" "dns_prefix" {
  length  = 8
  special = false
}


# ----------------------
# TLS Private Key
# ----------------------
resource "tls_private_key" "ssh" {
  count = var.admin_username == null ? 0 : 1

  algorithm = "RSA"
  rsa_bits  = 2048
}

# ----------------------
# Azure Kubernetes Service
# ----------------------
resource "azurerm_kubernetes_cluster" "main" {
  name                          = local.aks_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_prefix                    = local.dns_prefix
  kubernetes_version            = var.kubernetes_version
  node_resource_group           = var.node_resource_group
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "ingress_application_gateway" {
    for_each = var.application_gateway_id == null ? [] : ["application_gateway"]

    content {
      gateway_id = var.application_gateway_id
    }

  }

  role_based_access_control_enabled = var.role_based_access_control_enabled

  sku_tier = var.sku_tier

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    min_count  = var.default_node_pool.min_count
    max_count  = var.default_node_pool.max_count

    vm_size               = var.default_node_pool.vm_size
    enable_node_public_ip = var.public_network_access_enabled


    enable_auto_scaling  = var.enable_auto_scaling
    orchestrator_version = var.orchestrator_version
    # vnet_subnet_id       = var.vnet_subnet_id

    tags = merge(var.tags, var.windows_profile == null ? local.node_labels_linux : local.node_labels_windows)
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = var.network_plugin

    dynamic "load_balancer_profile" {
      for_each = var.load_balancer_profile != null ? ["load_balancer_profile"] : []

      content {
        outbound_ip_address_ids = null
      }
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider_enabled ? ["key_vault_secrets_provider"] : []

    content {
      secret_rotation_enabled  = var.secret_rotation_enabled
      secret_rotation_interval = var.secret_rotation_interval
    }
  }

  dynamic "linux_profile" {
    for_each = var.admin_username == null ? [] : ["linux_profile"]

    content {
      admin_username = var.admin_username

      ssh_key {
        key_data = replace(coalesce(var.public_ssh_key, tls_private_key.ssh[0].public_key_openssh), "\n", "")
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? ["maintenance_window"] : []

    content {
      dynamic "allowed" {
        for_each = var.maintenance_window.allowed == null ? [] : var.maintenance_window.allowed

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = var.maintenance_window.not_allowed == null ? [] : var.maintenance_window.not_allowed

        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender_enabled ? ["microsoft_defender"] : []

    content {
      log_analytics_workspace_id = try(azurerm_log_analytics_workspace.main[0].id, null)
    }
  }


  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  tags = var.tags
}


resource "azurerm_public_ip" "load_balancer_pip" {
  count = var.public_network_access_enabled ? 1 : 0

  name                = local.aks_name
  resource_group_name = data.azurerm_resource_group.nodes_rg.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}


resource "azurerm_kubernetes_cluster_node_pool" "main" {
  for_each = var.node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count

  tags = var.tags
}

resource "azurerm_container_registry" "main" {
  count = var.create_acr ? 1 : 0

  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = var.admin_username == null ? false : true

  identity {
    type = "SystemAssigned"
  }

  dynamic "encryption" {
    for_each = var.encryption_enabled ? ["acr"] : []

    content {
      enabled            = true
      key_vault_key_id   = var.key_vault_key_id
      identity_client_id = var.identity_client_id
    }
  }

  tags = var.tags
}

# Assign AcrPull role to AKS's managed identity on the ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main[0].id
  skip_service_principal_aad_check = true
}

# Assign Network Contributor role to AKS's managed identity on the VNet
resource "azurerm_role_assignment" "aks_network_contributor" {
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope                = var.vnet_id
}

# Assign Network Contributor role to AKS's managed identity on the subnets
resource "azurerm_role_assignment" "aks_subnet_contributor" {
  for_each = var.subnet_ids

  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope                = each.value
}

# Assign Network Contributor role to AKS's managed identity on the subnets
resource "azurerm_role_assignment" "aks_node_resource_group_network_contributor" {
  for_each = var.node_resource_group != null ? var.subnet_ids : {}

  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_resource_group.nodes_rg.id
}

# Assign Reader role to AGIC's managed identity on the resource group
resource "azurerm_role_assignment" "agic_resource_group_reader_main" {
  count                = var.application_gateway_id != null && length(data.azurerm_resource_group.main) > 0 ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Reader"
  scope                = data.azurerm_resource_group.nodes_rg.id
}

# Assign Contributor role to AGIC's managed identity on the Application Gateway
resource "azurerm_role_assignment" "agic_apigw_contributor_main" {
  count                = var.application_gateway_id != null && length(data.azurerm_resource_group.main) > 0 ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Contributor"
  scope                = var.application_gateway_id
}


# Assign Reader role to AGIC's managed identity on the resource group
resource "azurerm_role_assignment" "agic_resource_group_reader" {
  count                = var.application_gateway_id != null && length(data.azurerm_resource_group.nodes_rg) > 0 ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Reader"
  scope                = data.azurerm_resource_group.nodes_rg.id
}

# Assign Contributor role to AGIC's managed identity on the Application Gateway
resource "azurerm_role_assignment" "agic_apigw_contributor" {
  count                = var.application_gateway_id != null && length(data.azurerm_resource_group.nodes_rg) > 0 ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Contributor"
  scope                = var.application_gateway_id
}

# ----------------------
# Log Analytics Workspace
# ----------------------
resource "azurerm_log_analytics_workspace" "main" {
  count = var.create_log_analytics_workspace ? 1 : 0

  name                = local.log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days

  tags = var.tags
}

resource "azurerm_public_ip" "main" {
  name                = local.aks_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

  tags = var.tags
}

