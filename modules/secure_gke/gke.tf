## Building this around https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
## Google groups for GKE https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control#google-groups-for-gke
## For info on network policy: https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/

resource "google_container_cluster" "secure_gke" {
  #checkov:skip=CKV_GCP_21:Node doesn't need labels as it gets removed instantly
  #checkov:skip=CKV_GCP_23:Skipping as this test is failing. Setting `networking_mode` to VPC_NATIVE enables IP aliasing

  #TODO: Setup master auth and certs
  #checkov:skip=CKV_GCP_19
  #checkov:skip=CKV_GCP_20
  #checkov:skip=CKV_GCP_13


  provider = google-beta

  name     = "${var.project_id}-${var.gke_config.name_suffix}"
  project  = var.project_id
  location = var.region

  # Security
  enable_binary_authorization = true

  private_cluster_config {
    enable_private_endpoint = var.gke_config.enable_private_endpoint
    enable_private_nodes    = var.gke_config.enable_private_nodes
    master_ipv4_cidr_block  = var.gke_config.enable_private_nodes ? lookup(var.gke_config, "master_ipv4_cidr_block") : null
    master_global_access_config {
      enabled = var.gke_config.enable_global_access
    }
  }


  release_channel {
    channel = lookup(var.gke_config, "release_channel", "REGULAR")
  }

  network    = var.network_name
  subnetwork = var.subnet_name

  dynamic "database_encryption" {
    for_each = lookup(var.gke_config, "db_encrypt", true) ? [1] : []
    content {
      state    = "ENCRYPTED"
      key_name = google_kms_crypto_key.gke_kms_key[0].self_link
    }
  }

  cluster_telemetry {
    type = "ENABLED"
  }

  network_policy {
    enabled = true
  }

  addons_config {
    istio_config {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
  }

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  pod_security_policy_config {
    enabled = true
  }


  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {}

  # Remove the initial node pool
  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    google_kms_crypto_key_iam_member.gke_api_encrypt_decrypt
  ]
}

resource "google_container_node_pool" "node_pool" {
  for_each = lookup(var.gke_config, "node_pool_config", {})

  name     = each.key
  project  = var.project_id
  location = var.region
  cluster  = google_container_cluster.secure_gke.name

  max_pods_per_node = lookup(each.value, "max_pods_per_node", 110)

  # # This means that `min_node_count AND max_node_count` is required or it'll default to 3 (var.node_count default)
  initial_node_count = each.value.autoscaling ? lookup(each.value, "min_node_count") : var.node_count

  dynamic "autoscaling" {
    for_each = each.value.autoscaling ? [each.value] : []
    content {
      min_node_count = lookup(autoscaling.value, "min_node_count")
      max_node_count = lookup(autoscaling.value, "max_node_count")
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    # Forces a slow rolling upgrade
    max_surge       = 1
    max_unavailable = 1
  }

  node_config {
    machine_type    = each.value.machine_type
    service_account = google_service_account.gke_service_account[each.key].email
    preemptible     = lookup(each.value, "preemptible", false)
    tags            = lookup(each.value, "tag_list", [])
    #checkov:skip=CKV_GCP_22
    image_type      = lookup(each.value, "image_type", "COS")
    local_ssd_count = lookup(each.value, "local_ssd_count", 0)
    disk_size_gb    = lookup(each.value, "disk_size_gb", 100)
    labels          = lookup(each.value, "labels", null)
  }

  dynamic "timeouts" {
    for_each = lookup(each.value, "timeouts", null) == null ? {} : each.value.timeouts
    content {
      create = lookup(each.value, "create", "30m")
      update = lookup(each.value, "update", "30m")
      delete = lookup(each.value, "delete", "30m")
    }
  }
}
