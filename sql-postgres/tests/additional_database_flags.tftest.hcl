mock_provider "google" {}
mock_provider "google-beta" {}

override_data {
  target = data.google_compute_zones.available
  values = {
    names = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
  }
}

override_data {
  target = data.google_compute_network.network
  values = {
    id = "projects/test-project/global/networks/default"
  }
}

override_module {
  target = module.sql-db_postgresql
  outputs = {
    instance_name = "test-db-instance"
  }
}

variables {
  project_id          = "test-project"
  region              = "europe-west2"
  db_zone_selector    = "*"
  network_name        = "default"
  db_name             = "test-db"
  db_available_type   = "REGIONAL"
  db_backup           = false
  db_insights         = false
  deletion_protection = false
}

run "default_has_nine_flags" {
  command = plan

  assert {
    condition     = google_sql_user.gcp_developers.instance == "test-db-instance"
    error_message = "SQL user should reference the mocked instance"
  }
}

run "no_additional_flags_by_default" {
  command = plan

  assert {
    condition     = length(var.additional_database_flags) == 0
    error_message = "additional_database_flags should default to empty"
  }
}

run "additional_flags_are_accepted" {
  command = plan

  variables {
    additional_database_flags = [
      {
        name  = "cloudsql.enable_pg_cron"
        value = "on"
      },
    ]
  }

  assert {
    condition     = length(var.additional_database_flags) == 1
    error_message = "Should accept 1 additional flag"
  }

  assert {
    condition     = var.additional_database_flags[0].name == "cloudsql.enable_pg_cron"
    error_message = "Flag name should be cloudsql.enable_pg_cron"
  }
}

run "multiple_additional_flags" {
  command = plan

  variables {
    additional_database_flags = [
      {
        name  = "cloudsql.enable_pg_cron"
        value = "on"
      },
      {
        name  = "cloudsql.enable_pg_partman"
        value = "on"
      },
    ]
  }

  assert {
    condition     = length(var.additional_database_flags) == 2
    error_message = "Should accept 2 additional flags"
  }
}
