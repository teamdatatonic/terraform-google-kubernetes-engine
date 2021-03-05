output "cluster_name" {
  value       = google_container_cluster.secure_gke.name
  description = ""
}


output "cluster_id" {
  value       = google_container_cluster.secure_gke.id
  description = "an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}"
}

output "cluster_self_link" {
  value       = google_container_cluster.secure_gke.self_link
  description = "The server-defined URL for the GKE resource."
}

output "endpoint" {
  value = google_container_cluster.secure_gke.endpoint
}
