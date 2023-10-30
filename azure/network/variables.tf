variable "prefix" {
  description = "Prefix to be appended to the names of the resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location of the vnet to create."
  type        = string
  nullable    = false
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "bgp_community" {
  type        = string
  description = "(Optional) The BGP community attribute in format `<as-number>:<community-value>`."
  default     = null
}

variable "ddos_protection_plan" {
  description = "The set of DDoS protection plan configuration"
  type = object({
    enable = bool
    id     = string
  })
  default = null
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}

variable "route_tables" {
  description = "A map of subnet name to Route table"
  type        = map(string)
  default     = {}
}

variable "subnets_name_id" {
  description = "A map of subnet name to subnet ID"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "subnets" {
  description = "Map of subnets containing its attributes such as service delegation, prefixes, private endpoints and private links."
  type = map(object({
    prefixes                                      = list(string)
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
    service_delegation = optional(list(object({
      name    = string
      actions = optional(list(string))
    })))
    service_endpoints = optional(list(string))
  }))
  default = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "acctvnet"
}

variable "network_security_groups" {
  description = "List of security groups for each subnet."
  type = map(object({
    name        = optional(string)
    subnet_name = string
  }))
  default = {}
}

variable "octopus_tentacles_vnet_peering_tags" {
  description = "Tags used to identify VNets to be peered."
  type        = map(string)
  default = {
    "octopus_managed" = true
  }
}

variable "octopus_tentacles_vnet_peering_names" {
  type    = string
  default = "octopus-peering"
}

variable "dns_zone" {
  description = "The DNS zone name"
  type        = string
}


variable "dns_zone_record" {
  description = "The DNS zone name"
  type        = string
  default     = "octopus"
}


variable "create_network_security_group" {
  type    = bool
  default = true
}

variable "aks_vnet_name" {
  type        = string
  description = "The name of the vNet to peer with."
  default     = null
}

variable "create_api_gw" {
  type    = bool
  default = false
}

variable "octopus_load_balancer" {
  description = ""
  type        = map(string)
  default     = {}
}
