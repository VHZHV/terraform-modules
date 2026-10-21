locals {
  _region_short = join("", [for s in split("-", var.region) : substr(s, 0, 1)])
  region_short  = "${local._region_short}${substr(var.region, length(var.region) - 1, 1)}"
  name_stem     = var.name_suffix == null ? var.environment_name : "${var.environment_name}_${var.name_suffix}"
}

# Datastream connection profile for Cloud SQL PostgreSQL source
resource "google_datastream_connection_profile" "postgres_source" {
  display_name          = "${var.environment_name}-${var.group}-${local.region_short}-postgres-source"
  location              = var.region
  connection_profile_id = "${var.environment_name}-${var.group}-${local.region_short}-postgres-source"

  postgresql_profile {
    hostname = var.db.public_ip_address
    port     = 5432
    database = var.db.database_name
    username = google_sql_user.datastream_user.name
    password = google_sql_user.datastream_user.password
  }

  project = var.project_id

  depends_on = [
    null_resource.run_datastream_setup
  ]
}

# Datastream user for PostgreSQL replication
resource "google_sql_user" "datastream_user" {
  name     = "${local.name_stem}_datastream"
  instance = var.db.name
  password = var.password
  project  = var.project_id
}

locals {
  # Datastream private connection for VPC peering

  datastream_publication      = "${local.name_stem}_pub"
  datastream_replication_slot = "${local.name_stem}_${var.name_suffix == null ? "datastream_slot" : "slot"}"
  script_path                 = "${path.module}/scripts/set_up_replication"
  script_code_hash = sha1(
    join("", [for f in fileset(local.script_path, "*") : filesha1("${local.script_path}/${f}")],
      [

        var.db.connection_name,
        var.db.user_name,
        var.db.database_name,
        google_sql_user.datastream_user.name,
        local.datastream_publication,
        local.datastream_replication_slot
      ],
      # Appended only when set, so the hash is unchanged for existing callers.
      var.publication_tables == null ? [] : [join(",", var.publication_tables), "strict"],
    )
  )
}

resource "null_resource" "run_datastream_setup" {
  triggers = {
    always_run = "${local.script_code_hash}-${google_sql_user.datastream_user.name}"
  }

  provisioner "local-exec" {
    working_dir = local.script_path
    command     = "npm install && npm run exec"
    environment = merge({
      INSTANCE_CONNECTION_NAME = var.db.connection_name
      SUPERUSER_NAME           = var.db.user_name
      SUPERUSER_PASSWORD       = var.db.user_password
      DATABASE_NAME            = var.db.database_name
      DATASTREAM_USERNAME      = google_sql_user.datastream_user.name
      DATASTREAM_PASSWORD      = var.password
      PUBLICATION              = local.datastream_publication
      SLOT                     = local.datastream_replication_slot
      },
      var.publication_tables == null ? {} : {
        PUBLICATION_TABLES = join(",", var.publication_tables)
        STRICT             = "true"
    })
  }
}

# Connection profile for BigQuery destination
resource "google_datastream_connection_profile" "bigquery_destination" {
  display_name          = "${var.environment_name}-${var.group}-${local.region_short}-bigquery-dest"
  location              = var.region
  connection_profile_id = "${var.environment_name}-${var.group}-${local.region_short}-bigquery-dest"

  bigquery_profile {}

  project = var.project_id
}


resource "google_datastream_stream" "stream" {
  display_name  = "postgres to bigQuery ${var.group} ${local.region_short} ${var.environment_name}"
  location      = var.region
  project       = var.project_id
  stream_id     = "postgres-to-bigquery-${var.group}-${local.region_short}-${var.environment_name}"
  desired_state = var.desired_state
  source_config {
    source_connection_profile = google_datastream_connection_profile.postgres_source.name
    postgresql_source_config {
      max_concurrent_backfill_tasks = 12
      publication                   = local.datastream_publication
      replication_slot              = local.datastream_replication_slot
      include_objects {
        postgresql_schemas {
          schema = "public"
          dynamic "postgresql_tables" {
            for_each = var.tables
            iterator = table

            content {
              table = table.value
            }
          }
        }
      }
    }
  }

  destination_config {
    destination_connection_profile = google_datastream_connection_profile.bigquery_destination.name
    bigquery_destination_config {
      data_freshness = "900s"

      source_hierarchy_datasets {
        dataset_template {
          location          = var.bigquery_region
          dataset_id_prefix = "${var.group}_${var.environment_name}_"
        }
      }
    }
  }

  dynamic "backfill_all" {
    for_each = var.backfill == "all" ? [1] : []
    content {}
  }

  dynamic "backfill_none" {
    for_each = var.backfill == "none" ? [1] : []
    content {}
  }

  dynamic "rule_sets" {
    for_each = var.table_partitioning
    iterator = partition
    content {
      object_filter {
        source_object_identifier {
          postgresql_identifier {
            schema = "public"
            table  = partition.key
          }
        }
      }
      customization_rules {
        bigquery_partitioning {
          time_unit_partition {
            column                        = partition.value.column
            partitioning_time_granularity = "PARTITIONING_TIME_GRANULARITY_${partition.value.granularity}"
          }
        }
      }
    }
  }
}
