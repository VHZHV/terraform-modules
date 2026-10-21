mock_provider "google" {}
mock_provider "null" {}

variables {
  project_id       = "test-project"
  region           = "europe-west2"
  group            = "vehicles"
  environment_name = "production"
  bigquery_region  = "EU"
  tables           = ["ukvd_vehicles"]
  password         = "test-password"
  db = {
    connection_name   = "test-project:europe-west2:db"
    name              = "db"
    public_ip_address = "10.0.0.1"
    database_name     = "vehicles_cache"
    user_name         = "postgres"
    user_password     = "x"
  }
}

run "defaults" {
  command = plan

  assert {
    condition     = google_sql_user.datastream_user.name == "production_datastream"
    error_message = "datastream user name changed"
  }

  assert {
    condition     = google_datastream_stream.stream.desired_state == "RUNNING"
    error_message = "stream desired_state changed"
  }

  assert {
    condition     = length(google_datastream_stream.stream.backfill_all) == 1
    error_message = "backfill_all should be present by default"
  }

  assert {
    condition     = length(google_datastream_stream.stream.backfill_none) == 0
    error_message = "backfill_none should be absent by default"
  }

  assert {
    condition     = length(google_datastream_stream.stream.rule_sets) == 0
    error_message = "rule_sets should be absent by default"
  }

  assert {
    condition     = strcontains(null_resource.run_datastream_setup.triggers.always_run, "production_datastream")
    error_message = "setup trigger should include the datastream user name"
  }
}
