data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

data "google_compute_network" "network" {
  project = var.project_id
  name    = var.network_name
}

# trivy:ignore:avd-gcp-0014 False positive, this is actually set
# trivy:ignore:avd-gcp-0015 Don't set this as hozah-data needs to be able to connect to the database
# trivy:ignore:avd-gcp-0016 False positive, this is actually set
# trivy:ignore:avd-gcp-0017 I agree with having only a private IP, however, we need to have a public IP for support
# trivy:ignore:avd-gcp-0020 False positive, this is actually set
# trivy:ignore:avd-gcp-0022 False positive, this is actually set
# trivy:ignore:avd-gcp-0025 False positive, this is actually set
module "sql-db_postgresql" {
  source  = "terraform-google-modules/sql-db/google//modules/postgresql"
  version = "25.2.2"

  project_id        = var.project_id
  name              = var.db_name
  database_version  = "POSTGRES_17"
  region            = var.region
  zone              = local.db_zone
  tier              = var.tier
  availability_type = var.db_available_type
  edition           = "ENTERPRISE"

  enable_default_db   = false
  enable_default_user = false

  deletion_protection                      = var.deletion_protection
  deletion_protection_enabled              = var.deletion_protection
  read_replica_deletion_protection         = var.deletion_protection
  read_replica_deletion_protection_enabled = var.deletion_protection

  password_validation_policy_config = {
    min_length                  = 30
    complexity                  = "COMPLEXITY_DEFAULT"
    disallow_username_substring = true
  }

  backup_configuration = var.db_backup ? {
    enabled                        = true
    point_in_time_recovery_enabled = true
    retained_backups               = 21
    retention_unit                 = "COUNT"
  } : {}
  insights_config = var.db_insights ? {
    query_string_length     = 1024
    record_application_tags = false
    record_client_address   = false
  } : null
  ip_configuration = {
    ipv4_enabled    = true
    ssl_mode        = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    private_network = data.google_compute_network.network.id
    authorized_networks = [
      {
        value = "34.89.121.226"
      },
      {
        value = "35.197.249.117"
      },
      {
        value = "34.105.244.177"
      },
      {
        value = "35.242.151.51"
      },
      {
        value = "35.189.120.213"
      }
    ]
  }

  database_flags = [
    {
      name : "cloudsql.logical_decoding",
      value : "on"
    },
    {
      name : "cloudsql.iam_authentication",
      value : "on"
    },
    {
      name : "cloudsql.enable_pgaudit",
      value : "on"
    },
    {
      name : "log_temp_files",
      value : "0"
    },
    {
      name : "max_connections",
      value : var.max_connections
    },
    {
      name : "log_connections",
      value : "on"
    },
    {
      name : "log_lock_waits",
      value : "on"
    },
    {
      name : "log_disconnections",
      value : "on"
    },
    {
      name : "log_checkpoints",
      value : "on"
    },
  ]
}
