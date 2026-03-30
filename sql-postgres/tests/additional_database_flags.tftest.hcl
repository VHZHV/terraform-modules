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

run "additional_flag_is_appended" {
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
    condition = anytrue([
      for flag in output.database_flags : flag.name == "cloudsql.enable_pg_cron" && flag.value == "on"
    ])
    error_message = "cloudsql.enable_pg_cron should be present in database flags"
  }

  assert {
    condition = anytrue([
      for flag in output.database_flags : flag.name == "cloudsql.logical_decoding"
    ])
    error_message = "Default flags should be preserved when adding additional flags"
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
    condition = anytrue([
      for flag in output.database_flags : flag.name == "cloudsql.enable_pg_cron"
    ])
    error_message = "cloudsql.enable_pg_cron should be present"
  }

  assert {
    condition = anytrue([
      for flag in output.database_flags : flag.name == "cloudsql.enable_pg_partman"
    ])
    error_message = "cloudsql.enable_pg_partman should be present"
  }
}
