variable "project_id" {
  description = "The ID of the project where the GKE will be created."
  type        = string
}

variable "region" {
  description = "(Optional) The region in  which the resources will be created."
  type        = string
  default     = "europe-west2"
}

variable "environment_prefix" {
  description = "The GCP envioment where the cluster will be created."
  type        = string
  default     = "dev"
}

variable "gke_network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "subnets" {
  description = "The list of subnets to be created."
  type        = any
}

variable "routing_mode" {
  description = "The network routing mode (default 'REGIONAL')."
  type        = string
  default     = "REGIONAL"
}

variable "gke_config" {
  description = "Maps of GKE configurations."
  type        = any

}
