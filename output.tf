output "cluster_name" {
  description = "The name of the cluster, unique within the project and location."
  value       = module.secure_private_gke_v2.cluster_name
}


output "cluster_id" {
  description = "an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}."
  value       = module.secure_private_gke_v2.cluster_id
}

output "cluster_self_link" {
  description = "The server-defined URL for the GKE resource."
  value       = module.secure_private_gke_v2.cluster_self_link

}

output "endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = module.secure_private_gke_v2.endpoint
}
