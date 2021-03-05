variable "project_id" {
  description = "The ID of the project where the GKE will be created"
  type        = string
}

variable "region" {
  description = "Region where the cluster reside."
  type        = string
}

variable "gke_config" {
  description = "map of GKE configs."
}

variable "node_count" {
  description = "(Optional) The number of nodes per instance group."
  type        = number
  default     = 3

}

variable "network_name" {
  description = "(Optional) The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
  type        = string
}

variable "subnet_name" {
  description = "(Optional) The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
}
