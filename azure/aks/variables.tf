variable "location" {
  description = "The Azure location where resources should be deployed."
  type        = string
}

variable "cluster_name" {
  type        = string
  description = "(Optional) The name for the AKS resources created in the specified Azure Resource Group. This variable overwrites the 'prefix' var (The 'prefix' var will still be applied to the dns_prefix if it is set)"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to be imported"
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "vnet_id" {
  description = "Id of the virtual network where AKS is deployed."
  type        = string
  default     = null
}

variable "vnet_subnet_id" {
  type        = string
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "node_resource_group" {
  type        = string
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. Changing this forces a new resource to be created."
  default     = null
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Standard`"
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "The SKU Tier must be either `Free` or `Standard`. `Paid` is no longer supported since AzureRM provider v3.51.0."
  }
}


variable "orchestrator_version" {
  type        = string
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Enable node pool autoscaling"
  default     = false
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = null
}


variable "role_based_access_control_enabled" {
  type        = bool
  description = "Enable Role Based Access Control."
  default     = false
  nullable    = false
}
variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to `true`. Changing this forces a new resource to be created."
  default     = true
  nullable    = false
}


variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster. If empty, a random prefix will be generated."
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  default     = null
}


variable "create_resource_group" {
  description = "bool to enable creation of resource group."
  type        = bool
}

variable "prefix" {
  description = "Prefix to be added to all created resources."
  type        = string
}

variable "tags" {
  description = "Map of common tags to be given to all resources."
  type        = map(any)
}

variable "default_node_pool" {
  type = object({
    name       = string
    node_count = number
    min_count  = number
    max_count  = number
    vm_size    = string
  })
  description = "The default Azure AKS nodepool configuration."
  nullable    = false
}


variable "client_id" {
  type        = string
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment"
  default     = ""
  nullable    = false
}

variable "client_secret" {
  type        = string
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  default     = ""
  nullable    = false
}


variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "(Optional) Whether to use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster. For more details: https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver"
  default     = false
  nullable    = false
}


variable "admin_username" {
  type        = string
  description = "The username of the local administrator to be created on the Kubernetes cluster. Set this variable to `null` to turn off the cluster's `linux_profile`. Changing this forces a new resource to be created."
  default     = null
}


variable "public_ssh_key" {
  type        = string
  description = "A custom ssh key to control access to the AKS cluster. Changing this forces a new resource to be created."
  default     = ""
}


variable "secret_rotation_enabled" {
  type        = bool
  description = "Is secret rotation enabled? This variable is only used when `key_vault_secrets_provider_enabled` is `true` and defaults to `false`"
  default     = false
  nullable    = false
}

variable "secret_rotation_interval" {
  type        = string
  description = "The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is `true` and defaults to `2m`"
  default     = "2m"
  nullable    = false
}

variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking."
  default     = "kubenet"
  nullable    = false
}

variable "acr_name" {
  type        = string
  description = "Name of the ACR resource created for AKS."
  default     = ""
}

variable "create_acr" {
  type        = bool
  description = "Create ACR resource for AKS."
  default     = false
}

variable "admin_enabled" {
  description = "A boolean indicating whether or not the admin user is enabled for the Azure Container Registry"
  default     = true
}


variable "encryption_enabled" {
  description = "A boolean indicating whether or not encryption should be enabled for the Azure Container Registry"
  default     = false
  type        = bool
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key used for encryption."
  type        = string
  default     = ""
}

variable "identity_client_id" {
  default     = ""
  description = "The client ID of the managed identity associated with the encryption key."
  type        = string
}

variable "acr_sku" {
  description = "SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "aks_maintenance_name" {
  description = "Name of the maintenance configuration."
  type        = string
  default     = ""
}

variable "microsoft_defender_name" {
  description = "value of the microsoft defender name."
  type        = string
  default     = ""
}

variable "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace."
  type        = string
  default     = ""
}

variable "log_analytics_workspace_sku" {
  description = "SKU of the log analytics workspace."
  type        = string
  default     = "Free"
}

variable "log_analytics_workspace_retention_in_days" {
  description = "Retention in days of the log analytics workspace."
  type        = number
  default     = null
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    })),
    not_allowed = list(object({
      end   = string
      start = string
    })),
  })
  description = "(Optional) Maintenance configuration of the managed cluster."
  default     = null
}

variable "create_log_analytics_workspace" {
  description = "Create log analytics workspace"
  type        = bool
  default     = false
}

variable "microsoft_defender_enabled" {
  type        = bool
  description = "(Optional) Is Microsoft Defender on the cluster enabled? Requires `var.log_analytics_workspace_enabled` to be `true` to set this variable to `true`."
  default     = false
  nullable    = false
}

variable "windows_profile" {
  description = "(Optional) The Windows Profile for the cluster."
  type = object({
    admin_username = string
    admin_password = string
  })
  default = null
}

variable "application_gateway_id" {
  description = "The ID of the Application Gateway to be used as the ingress controller for the AKS cluster."
  type        = string
  default     = null
}

variable "node_pools" {
  type = map(object({
    vm_size    = string
    node_count = number
  }))
  default = {}
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet ids to assign AKS's managed identity the Network Contributor role on"
}

variable "load_balancer_profile" {
  type = object({
    outbound_ip_address_ids = list(string)
  })
  default     = null
  description = "A load_balancer_profile block as defined below."
}
