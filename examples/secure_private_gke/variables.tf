variable "project_id" {
  description = "The ID of the project where the GKE will be created"
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "environment_prefix" {
  type    = string
  default = "dev"
}

variable "gke_network_name" {
  type    = string
  default = "example-usage-vpc"
}

variable "secure_subnet" {
  type = any
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
  type    = string
  default = "REGIONAL"
}

variable "gke_config" {

}
