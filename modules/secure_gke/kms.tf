resource "google_kms_key_ring" "gke_kms_keyring" {
  project  = var.project_id
  name     = "gke-encrypt-ring"
  location = var.region
}

resource "google_kms_crypto_key" "gke_kms_key" {
  name     = "${var.gke_config.name_suffix}-encryption-key"
  key_ring = google_kms_key_ring.gke_kms_keyring.id
  # Rotation period : 30 days as standard
  rotation_period = "2592000s"
  purpose         = lookup(var.gke_config, "kms_purpose", "ENCRYPT_DECRYPT")
}


# Required to get the project number for KMS encrypt/decrypt
data "google_project" "project" {
  project_id = var.project_id
}

resource "google_kms_crypto_key_iam_member" "gke_api_encrypt_decrypt" {
  crypto_key_id = google_kms_crypto_key.gke_kms_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
}
