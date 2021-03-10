variable "project_id" {
  description = "The ID of the project where the GKE will be created."
  type        = string
}

variable "region" {
  description = "Region where the resources will be created."
  type        = string
}

variable "gke_config" {
  description = "Maps of GKE configurations."
  type        = any
}

variable "network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "subnet_name" {
  description = "The list of subnets to be created."
  type        = string
}
