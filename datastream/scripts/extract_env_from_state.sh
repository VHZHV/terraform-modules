#!/usr/bin/env bash

terraform -chdir=.. state pull > /tmp/terraform.tfstate.json

INSTANCE_CONNECTION_NAME=$(jq -r '.resources[] | select(.type == "google_sql_database_instance" and .mode == "data") | .instances[0].attributes.connection_name' /tmp/terraform.tfstate.json)
SUPERUSER_NAME=$(jq -r '.resources[] | select(.module == "module.db" and .type == "google_sql_user" and .name == "admin_user") | .instances[0].attributes.name' /tmp/terraform.tfstate.json)
DATABASE_NAME=$(jq -r '.resources[] | select(.module == "module.db" and .type == "google_sql_database" and .name == "main_database") | .instances[0].attributes.name' /tmp/terraform.tfstate.json)
DATASTREAM_USERNAME=$(jq -r '.resources[] | select(.type == "google_sql_user" and .name == "datastream_user") | .instances[0].attributes.name' /tmp/terraform.tfstate.json)
SUPERUSER_PASSWORD=$(jq -r '.resources[] | select(.module == "module.db" and .type == "random_password" and .name == "admin_user_password") | .instances[0].attributes.result' /tmp/terraform.tfstate.json)
DATASTREAM_PASSWORD=$(jq -r '.resources[] | select(.type == "random_password" and .name == "datastream_password") | .instances[0].attributes.result' /tmp/terraform.tfstate.json)

BIGQUERY_DISPLAY=$(jq -r '.resources[] | select(.type == "google_datastream_connection_profile" and .name == "bigquery_destination") | .instances[0].attributes.display_name' /tmp/terraform.tfstate.json)
ENV_NAME=$(echo "$BIGQUERY_DISPLAY" | cut -d'-' -f1)

rm /tmp/terraform.tfstate.json

echo "export INSTANCE_CONNECTION_NAME=\"${INSTANCE_CONNECTION_NAME}\""
echo "export SUPERUSER_NAME=\"${SUPERUSER_NAME}\""
echo "export DATABASE_NAME=\"${DATABASE_NAME}\""
echo "export DATASTREAM_USERNAME=\"${DATASTREAM_USERNAME}\""
echo "export SUPERUSER_PASSWORD=\"${SUPERUSER_PASSWORD}\""
echo "export DATASTREAM_PASSWORD=\"${DATASTREAM_PASSWORD}\""
echo "export PUBLICATION=\"${ENV_NAME}_pub\""
echo "export SLOT=\"${ENV_NAME}_datastream_slot\""
echo "export CONSOLE_TABLES=\"allow_list,allow_list_entry,income_report,omni_allow_list_mapping,role,site,site_mapping,user_privileges,user_role\""
