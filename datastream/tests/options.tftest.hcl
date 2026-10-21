mock_provider "google" {}
mock_provider "null" {}

variables {
  project_id       = "test-project"
  region           = "europe-west2"
  group            = "parking"
  environment_name = "production"
  bigquery_region  = "EU"
  tables           = ["parking_session"]
  password         = "test-password"
  db = {
    connection_name   = "test-project:europe-west2:db"
    name              = "db"
    public_ip_address = "10.0.0.1"
    database_name     = "parking_sessions"
    user_name         = "postgres"
    user_password     = "x"
  }
}

run "all_options" {
  command = plan

  variables {
    name_suffix        = "parking_sessions"
    publication_tables = ["parking_session"]
    backfill           = "none"
    desired_state      = "NOT_STARTED"
    table_partitioning = { parking_session = { column = "received_at" } }
  }

  assert {
    condition     = google_sql_user.datastream_user.name == "production_parking_sessions_datastream"
    error_message = "suffixed user name wrong"
  }

  assert {
    condition     = google_datastream_stream.stream.source_config[0].postgresql_source_config[0].replication_slot == "production_parking_sessions_slot"
    error_message = "suffixed slot name wrong"
  }

  assert {
    condition     = google_datastream_stream.stream.source_config[0].postgresql_source_config[0].publication == "production_parking_sessions_pub"
    error_message = "suffixed publication name wrong"
  }

  assert {
    condition     = length(google_datastream_stream.stream.backfill_none) == 1
    error_message = "backfill_none should be present"
  }

  assert {
    condition     = length(google_datastream_stream.stream.backfill_all) == 0
    error_message = "backfill_all should be absent"
  }

  assert {
    condition     = google_datastream_stream.stream.desired_state == "NOT_STARTED"
    error_message = "desired_state not applied"
  }

  assert {
    condition     = length(google_datastream_stream.stream.rule_sets) == 1
    error_message = "expected one rule_sets block"
  }

  assert {
    condition = (
      one(google_datastream_stream.stream.rule_sets).object_filter[0].source_object_identifier[0].postgresql_identifier[0].schema == "public"
      && one(google_datastream_stream.stream.rule_sets).object_filter[0].source_object_identifier[0].postgresql_identifier[0].table == "parking_session"
    )
    error_message = "rule_sets object filter should target public.parking_session"
  }

  assert {
    condition = (
      one(google_datastream_stream.stream.rule_sets).customization_rules[0].bigquery_partitioning[0].time_unit_partition[0].column == "received_at"
      && one(google_datastream_stream.stream.rule_sets).customization_rules[0].bigquery_partitioning[0].time_unit_partition[0].partitioning_time_granularity == "PARTITIONING_TIME_GRANULARITY_DAY"
    )
    error_message = "partitioning should be day on received_at"
  }
}

run "underscored_group_with_suffix" {
  command = plan

  variables {
    group       = "parking_sessions"
    name_suffix = "parking_sessions"
  }

  assert {
    condition     = google_datastream_stream.stream.stream_id == "postgres-to-bigquery-parking-sessions-ew2-production"
    error_message = "stream_id should hyphenate the group"
  }

  assert {
    condition     = google_datastream_connection_profile.postgres_source.connection_profile_id == "production-parking-sessions-ew2-postgres-source"
    error_message = "source connection_profile_id should hyphenate the group"
  }

  assert {
    condition     = google_datastream_connection_profile.bigquery_destination.connection_profile_id == "production-parking-sessions-ew2-bigquery-dest"
    error_message = "destination connection_profile_id should hyphenate the group"
  }

  assert {
    condition     = google_datastream_stream.stream.destination_config[0].bigquery_destination_config[0].source_hierarchy_datasets[0].dataset_template[0].dataset_id_prefix == "parking_sessions_production_"
    error_message = "dataset_id_prefix must keep the underscored group"
  }
}

# Non-file trigger inputs must not change for default callers; changing the
# script files re-runs setup once.
run "default_trigger_inputs_unchanged" {
  command = plan

  assert {
    condition     = null_resource.run_datastream_setup.triggers.always_run == "${sha1(join("", [for f in fileset("${path.module}/scripts/set_up_replication", "*") : filesha1("${path.module}/scripts/set_up_replication/${f}")], ["test-project:europe-west2:db", "postgres", "parking_sessions", "production_datastream", "production_pub", "production_datastream_slot"]))}-production_datastream"
    error_message = "default-case non-file trigger inputs changed"
  }
}

run "invalid_backfill" {
  command = plan
  variables {
    backfill = "some"
  }
  expect_failures = [var.backfill]
}

run "invalid_desired_state" {
  command = plan
  variables {
    desired_state = "STOPPED"
  }
  expect_failures = [var.desired_state]
}

run "empty_publication_tables" {
  command = plan
  variables {
    publication_tables = []
  }
  expect_failures = [var.publication_tables]
}

run "non_bare_publication_table" {
  command = plan
  variables {
    publication_tables = ["public.foo"]
  }
  expect_failures = [var.publication_tables]
}
