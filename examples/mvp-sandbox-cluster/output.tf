output "cluster_name" {
  description = "The name of the cluster, unique within the project and location."
  value       = module.mvp_sandbox_cluster.cluster_name
}


output "cluster_id" {
  description = "an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}."
  value       = module.mvp_sandbox_cluster.cluster_id
}

output "cluster_self_link" {
  description = "The server-defined URL for the GKE resource."
  value       = module.mvp_sandbox_cluster.cluster_self_link

}

output "endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = module.mvp_sandbox_cluster.endpoint
}

output "node_pool_sa_email" {
  description = "The node pool service account email."
  value       = module.mvp_sandbox_cluster.node_pool_sa_email
}
