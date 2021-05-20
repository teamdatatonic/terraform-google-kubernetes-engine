resource "google_service_account" "gke_service_account" {
  #checkov:skip=CKV2_GCP_3:Latest version of checkov has this failing, looks to be an internal checkov bug

  for_each     = lookup(var.gke_config, "node_pool_config", {})
  project      = var.project_id
  account_id   = "gke-np-${each.key}-sa"
  display_name = "GKE Service Account"
}

locals {
  members_policy_pairs = var.gke_project_iam == null ? [] : flatten([

    for role in var.gke_project_iam : [
      for sa in google_service_account.gke_service_account : {
        role   = "roles/${role}"
        member = "serviceAccount:${sa.email}"
      }
    ]
  ])
  role_members_length = local.members_policy_pairs != [] ? length(local.members_policy_pairs) : 0


}

resource "google_project_iam_member" "service_account-roles" {
  count = local.role_members_length

  project = var.project_id
  role    = lookup(local.members_policy_pairs[count.index], "role")
  member  = lookup(local.members_policy_pairs[count.index], "member")
  depends_on = [
  google_service_account.gke_service_account]
}
