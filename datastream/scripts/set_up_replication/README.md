# Database Replication Setup Script

This Node.js script sets up PostgreSQL logical replication for Google Cloud SQL instances, configuring the necessary users, publications, and replication slots for database streaming.

## Overview

The script performs the following operations:

1. **Superuser Operations**: Uses a superuser account to grant replication privileges, database permissions, and create publications
2. **Datastream User Operations**: Uses the datastream user account to create logical replication slots

The script grants the datastream user `pg_read_all_data` privileges and sets up logical replication for streaming database changes.

## Environment Variables

The following environment variables must be set:

| Variable | Description |
|----------|-------------|
| `INSTANCE_CONNECTION_NAME` | Google Cloud SQL instance connection name (format: `project:region:instance`) |
| `DATABASE_NAME` | Target database name |
| `SUPERUSER_NAME` | Superuser account name (typically `cloudsqlsuperuser`) |
| `SUPERUSER_PASSWORD` | Password for the superuser account |
| `DATASTREAM_USERNAME` | Username for the datastream replication user |
| `DATASTREAM_PASSWORD` | Password for the datastream user |
| `PUBLICATION` | Name of the publication to create |
| `SLOT` | Name of the logical replication slot to create |
