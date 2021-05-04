variable "project_id" {
  description = "The ID of the project where the GKE will be created."
  type        = string
}

variable "gke_config" {
  description = "Maps of GKE configurations."
  type        = any
}

variable "region" {
  description = "(Optional) The region in  which the cluster master will be created, as well as the node pool location."
  type        = string
}

variable "environment_prefix" {
  description = "The GCP envioment where the cluster will be created."
  type        = string
}

variable "gke_network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "secure_subnet" {
  description = "The list of subnets to be created."
  type        = any
  default = [
    {
      subnet_name   = "secure-subnet-gke",
      subnet_ip     = "192.168.0.0/20",
      subnet_region = "europe-west2",
      enable_logs   = false
    }
  ]

}

variable "routing_mode" {
  description = "The network routing mode (default 'REGIONAL')."
  type        = string
  default     = "REGIONAL"
}

variable "gke_project_iam" {
  description = "The list of roles to assign to the gke service account."
  type        = list(string)
  default     = null
}
