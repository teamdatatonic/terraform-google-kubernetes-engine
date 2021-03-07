resource "google_service_account" "gke_service_account" {
  for_each     = lookup(var.gke_config, "node_pool_config", {})
  project      = var.project_id
  account_id   = "gke-np-${each.key}-sa"
  display_name = "GKE Service Account"
}
