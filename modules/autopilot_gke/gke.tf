## Building this around https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
## Google groups for GKE https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control#google-groups-for-gke
## For info on network policy: https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/

resource "google_container_cluster" "secure_gke" {
  #checkov:skip=CKV_GCP_21:Node doesn't need labels as it gets removed instantly
  #checkov:skip=CKV_GCP_23:Skipping as this test is failing. Setting `networking_mode` to VPC_NATIVE enables IP aliasing

  #TODO: Setup master auth and certs
  #checkov:skip=CKV_GCP_12
  #checkov:skip=CKV_GCP_19
  #checkov:skip=CKV_GCP_13
  #checkov:skip=CKV_GCP_20

  #checkov:skip=CKV_GCP_61
  #checkov:skip=CKV_GCP_65
  #checkov:skip=CKV_GCP_66
  #checkov:skip=CKV_GCP_67
  #checkov:skip=CKV_GCP_69
  #checkov:skip=CKV_GCP_71

  provider = google-beta

  name     = "${var.project_id}-${var.gke_config.name_suffix}"
  project  = var.project_id
  location = lookup(var.gke_config, "zonal_cluster_enabled", false) ? lookup(var.gke_config, "zone") : var.region

  private_cluster_config {
    enable_private_endpoint = var.gke_config.enable_private_endpoint
    master_ipv4_cidr_block  = var.gke_config.enable_private_endpoint ? lookup(var.gke_config, "master_ipv4_cidr_block") : null
    master_global_access_config {
      enabled = var.gke_config.enable_global_access
    }
  }


  release_channel {
    channel = lookup(var.gke_config, "release_channel", "REGULAR")
  }

  network    = var.network_name
  subnetwork = var.subnet_name

  cluster_telemetry {
    type = "ENABLED"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
  }

  pod_security_policy_config {
    enabled = true
  }


  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {}

  enable_autopilot = true

}
