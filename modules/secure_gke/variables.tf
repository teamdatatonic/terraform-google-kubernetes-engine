variable "project_id" {
  description = "The ID of the project where the GKE will be created."
  type        = string
}

variable "region" {
  description = "Region where the cluster resides."
  type        = string
}

variable "gke_config" {
  description = "Maps of GKE configurations."
  type        = any
}

variable "node_count" {
  description = "(Optional) The number of nodes per instance group."
  type        = number
  default     = 3

}

variable "network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "subnet_name" {
  description = "The list of subnets to be created."
  type        = string
}
