import pg from "pg";
import {Connector} from "@google-cloud/cloud-sql-connector";
import {GoogleAuth} from 'google-auth-library';
import {createPublicationSql, missingTablesSql} from "./sql.mjs";

const {Pool} = pg;

const strict = process.env.STRICT === "true";
const publicationTables = process.env.PUBLICATION_TABLES
    ? process.env.PUBLICATION_TABLES.split(",").map((t) => t.trim()).filter(Boolean)
    : null;

// Log a failed command and carry on, or stop with a non-zero exit when STRICT=true.
function failed(error) {
    console.log(`❌ Error: ${error.message}`);
    if (strict) {
        process.exit(1);
    }
}

const connector = new Connector(
    {
        auth: new GoogleAuth({
            clientOptions: {
                project_id: process.env.INSTANCE_CONNECTION_NAME.split(":")[0],
            },
        }),
    }
);

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
        failed(error);
    }
}

console.log(`\nCreating publication for ${publicationTables === null ? "all tables" : publicationTables.join(", ")}...`);
const createPublication = createPublicationSql(process.env.PUBLICATION, publicationTables);
console.log(`Executing: ${createPublication}`);
try {
    const publicationResult = await superuserPool.query(createPublication);
    console.log("✅ Success - Command executed successfully");
    console.log(`   Command: ${publicationResult.command}`);
} catch (error) {
    failed(error);
}

if (publicationTables !== null) {
    // An existing publication keeps its table list, so add anything newly requested.
    try {
        const existing = await superuserPool.query(
            "SELECT schemaname || '.' || tablename AS name FROM pg_publication_tables WHERE pubname = $1",
            [process.env.PUBLICATION],
        );
        const statements = missingTablesSql(
            process.env.PUBLICATION,
            publicationTables,
            existing.rows.map((row) => row.name),
        );
        for (const statement of statements) {
            console.log(`Executing: ${statement}`);
            await superuserPool.query(statement);
            console.log("✅ Success - Command executed successfully");
        }
    } catch (error) {
        failed(error);
    }
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
    failed(error);
}

console.log("\nClosing datastream connection...");
await datastreamPool.end();
console.log("\nClosing Cloud SQL connector...");
connector.close();
