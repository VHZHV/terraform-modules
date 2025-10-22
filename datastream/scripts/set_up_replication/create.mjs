import pg from "pg";
import { Connector } from "@google-cloud/cloud-sql-connector";

const { Pool } = pg;

const connector = new Connector();

const clientOpts = await connector.getOptions({
  instanceConnectionName: process.env.INSTANCE_CONNECTION_NAME,
  ipType: "PUBLIC",
  authType: "IAM",
});

console.log("Connection to " + process.env.DATABASE_NAME);

// Superuser pool using cloudsqlsuperuser role
const superuserPool = new Pool({
  ...clientOpts,
  user: process.env.SUPERUSER_NAME,
  password: process.env.SUPERUSER_PASSWORD,
  database: process.env.DATABASE_NAME,
  max: 5,
});

// Execute each permission command separately and show results
const permissionCommands = [
  {
    description: "Granting REPLICATION privilege to datastream user",
    sql: `ALTER USER ${process.env.DATASTREAM_USERNAME} WITH REPLICATION;`,
  },
  {
    description: "Granting CONNECT privilege on database",
    sql: `GRANT CONNECT ON DATABASE ${process.env.DATABASE_NAME} TO ${process.env.DATASTREAM_USERNAME};`,
  },
  {
    description: "Granting USAGE privilege on public schema",
    sql: `GRANT USAGE ON SCHEMA public TO ${process.env.DATASTREAM_USERNAME};`,
  },
  {
    description: "Granting select to data",
    sql: `GRANT pg_read_all_data TO ${process.env.DATASTREAM_USERNAME};`,
  },
];

for (const command of permissionCommands) {
  console.log(`\n${command.description}...`);
  console.log(`Executing: ${command.sql}`);
  try {
    const result = await superuserPool.query(command.sql);
    console.log(`✅ Success - Command executed successfully`);
    if (result.rowCount !== undefined) {
      console.log(`   Command: ${result.command}`);
    }
  } catch (error) {
    console.log(`❌ Error: ${error.message}`);
  }
}

console.log("\nCreating publication for all tables...");
console.log(
  `Executing: DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = '${process.env.PUBLICATION}') THEN CREATE PUBLICATION ${process.env.PUBLICATION} FOR ALL TABLES; END IF; END$$;`,
);
try {
  const publicationResult = await superuserPool.query(
    `DO $$
    BEGIN
      IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = '${process.env.PUBLICATION}') THEN
        CREATE PUBLICATION ${process.env.PUBLICATION} FOR ALL TABLES;
      END IF;
    END$$;`,
  );
  console.log("✅ Success - Command executed successfully");
  console.log(`   Command: ${publicationResult.command}`);
} catch (error) {
  console.log(`❌ Error: ${error.message}`);
}

console.log("\nClosing superuser connection...");
await superuserPool.end();

// Create datastream pool using datastream credentials
console.log("\nConnecting as datastream user...");
const datastreamPool = new Pool({
  ...clientOpts,
  user: process.env.DATASTREAM_USERNAME,
  password: process.env.DATASTREAM_PASSWORD,
  database: process.env.DATABASE_NAME,
  max: 5,
});

console.log("\nCreating logical replication slot...");
console.log(
  `Executing: DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_replication_slots WHERE slot_name = '${process.env.SLOT}') THEN PERFORM PG_CREATE_LOGICAL_REPLICATION_SLOT('${process.env.SLOT}', 'pgoutput'); END IF; END$$;`,
);
try {
  const slotResult = await datastreamPool.query(
    `
    DO $$
    BEGIN
      IF NOT EXISTS (SELECT 1 FROM pg_replication_slots WHERE slot_name = '${process.env.SLOT}') THEN
        PERFORM PG_CREATE_LOGICAL_REPLICATION_SLOT('${process.env.SLOT}', 'pgoutput');
      END IF;
    END$$;`,
  );
  console.log("✅ Success - Command executed successfully");
  console.log(`   Command: ${slotResult.command}`);
} catch (error) {
  console.log(`❌ Error: ${error.message}`);
}

console.log("\nClosing datastream connection...");
await datastreamPool.end();
console.log("\nClosing Cloud SQL connector...");
connector.close();
