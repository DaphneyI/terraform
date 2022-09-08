variable "project_id" {
  type = string
}

variable "network" {
  type    = string
  default = null
}
variable "environment" {
  type    = string
  default = "dev"
}
variable "regional" {
  type    = bool
  default = true
}
variable "region" {
  type = string
}
variable "zones" {
  type    = list(any)
  default = []

}
variable "enable_private_endpoint" {
  type    = bool
  default = true
}
variable "grant_registry_access" {
  type    = bool
  default = true
}
variable "cluster_name" {
  type = string
}
variable "enable_vertical_pod_autoscaling" {
  type    = bool
  default = false
}
variable "horizontal_pod_autoscaling" {
  type    = bool
  default = true
}
variable "compute_engine_service_account" {
  type    = string
  default = null
}
variable "create_node_service_account" {
  type    = bool
  default = true
}
variable "max_pods_per_node" {
  type    = number
  default = 110
}
variable "pods_range_name" {
  type = string
}
variable "svc_range_name" {
  
}
variable "add_cluster_firewall_rules" {
  type    = bool
  default = false
}
variable "cluster_firewall_inbound_ports" {
  type = list(string)
  default = [
    "8443",
    "9443",
    "15017"
  ]
}
variable "master_authorized_networks" {
  type = list(object({
    cidr_block = string
    display_name = string
  }))
}
variable "kubernetes_version" {
  type    = string
  default = "latest"
}
variable "nodepools" {
  type = list(map(string))
  default = [
    { "name" : "default-pool" }
  ]
}
variable "nodepool_labels" {
  type = map(map(string))
  default = {
    "all" : {},
    "default-node-pool" : {}
  }
}
variable "nodepool_taints" {
  type = map(list(object({
    key    = string
    value  = string
    effect = string
  })))
  default = {
    "all" : [],
    "default-node-pool" : []
  }

}
variable "cluster_labels" {
  type    = map(string)
  default = {}
}

