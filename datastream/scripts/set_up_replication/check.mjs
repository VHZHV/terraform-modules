import pg from "pg";
import { Connector } from "@google-cloud/cloud-sql-connector";

const { Pool } = pg;

// Check if all required environment variables are set
const requiredVars = ['INSTANCE_CONNECTION_NAME', 'SUPERUSER_NAME', 'SUPERUSER_PASSWORD', 'DATABASE_NAME', 'DATASTREAM_USERNAME', 'CONSOLE_TABLES'];
const missingVars = requiredVars.filter(varName => !process.env[varName]);

if (missingVars.length > 0) {
    console.error('❌ Missing required environment variables:', missingVars.join(', '));
    process.exit(1);
}

const connector = new Connector();
const clientOpts = await connector.getOptions({
    instanceConnectionName: process.env.INSTANCE_CONNECTION_NAME,
    ipType: "PUBLIC",
});

// Connect using superuser to check privileges
const superuserPool = new Pool({
    ...clientOpts,
    user: process.env.SUPERUSER_NAME,
    password: process.env.SUPERUSER_PASSWORD,
    database: process.env.DATABASE_NAME,
    max: 5,
});

console.log("🔍 Checking DataStream privileges...\n");

const consoleTables = process.env.CONSOLE_TABLES.split(',');

try {
    // 1. Check if DataStream user exists and has REPLICATION privilege
    console.log("1️⃣ Checking DataStream user and REPLICATION privilege...");
    const userResult = await superuserPool.query(`
        SELECT usename, usesuper, userepl
        FROM pg_user
        WHERE usename = $1
    `, [process.env.DATASTREAM_USERNAME]);

    if (userResult.rows.length === 0) {
        console.log("❌ DataStream user does not exist");
    } else {
        const user = userResult.rows[0];
        console.log(`✅ User '${user.usename}' exists`);
        console.log(`   - Superuser: ${user.usesuper}`);
        console.log(`   - Replication: ${user.userepl}`);

        if (!user.userepl) {
            console.log("⚠️  User does not have REPLICATION privilege");
        }
    }

    // 2. Check database CONNECT privilege
    console.log("\n2️⃣ Checking database CONNECT privilege...");
    const dbPrivResult = await superuserPool.query(`
        SELECT has_database_privilege($1, $2, 'CONNECT') as has_connect
    `, [process.env.DATASTREAM_USERNAME, process.env.DATABASE_NAME]);

    if (dbPrivResult.rows[0].has_connect) {
        console.log("✅ Has CONNECT privilege on database");
    } else {
        console.log("❌ Missing CONNECT privilege on database");
    }

    // 3. Check schema USAGE privilege
    console.log("\n3️⃣ Checking schema USAGE privilege...");
    const schemaPrivResult = await superuserPool.query(`
        SELECT has_schema_privilege($1, 'public', 'USAGE') as has_usage
    `, [process.env.DATASTREAM_USERNAME]);

    if (schemaPrivResult.rows[0].has_usage) {
        console.log("✅ Has USAGE privilege on public schema");
    } else {
        console.log("❌ Missing USAGE privilege on public schema");
    }

    // 4. List all existing tables in public schema
    console.log("\n4️⃣ Checking existing tables in public schema...");
    const allTablesResult = await superuserPool.query(`
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'
        ORDER BY table_name
    `);

    const existingTables = allTablesResult.rows.map(row => row.table_name);
    console.log("Existing tables:", existingTables.join(', '));

    // 5. Check SELECT privileges on required console tables
    console.log("\n5️⃣ Checking SELECT privileges on required console tables...");

    const missingTables = [];
    const tablesWithoutPrivileges = [];
    const tablesWithPrivileges = [];

    for (const tableName of consoleTables) {
        // Check if table exists
        const tableExists = existingTables.includes(tableName);

        if (!tableExists) {
            missingTables.push(tableName);
            console.log(`❌ Table 'public.${tableName}' does not exist`);
            continue;
        }

        // Check SELECT privilege
        const selectPrivResult = await superuserPool.query(`
            SELECT has_table_privilege($1, $2, 'SELECT') as has_select
        `, [process.env.DATASTREAM_USERNAME, `public.${tableName}`]);

        if (selectPrivResult.rows[0].has_select) {
            tablesWithPrivileges.push(tableName);
            console.log(`✅ Has SELECT privilege on 'public.${tableName}'`);
        } else {
            tablesWithoutPrivileges.push(tableName);
            console.log(`❌ Missing SELECT privilege on 'public.${tableName}'`);
        }
    }

    // 6. Check publication exists
    console.log("\n6️⃣ Checking publication...");
    const pubResult = await superuserPool.query(`
        SELECT pubname FROM pg_publication WHERE pubname = $1
    `, [process.env.PUBLICATION]);

    if (pubResult.rows.length > 0) {
        console.log(`✅ Publication '${process.env.PUBLICATION}' exists`);
    } else {
        console.log(`❌ Publication '${process.env.PUBLICATION}' does not exist`);
    }

    // 7. Check replication slot exists
    console.log("\n7️⃣ Checking replication slot...");
    const slotResult = await superuserPool.query(`
        SELECT slot_name FROM pg_replication_slots WHERE slot_name = $1
    `, [process.env.SLOT]);

    if (slotResult.rows.length > 0) {
        console.log(`✅ Replication slot '${process.env.SLOT}' exists`);
    } else {
        console.log(`❌ Replication slot '${process.env.SLOT}' does not exist`);
    }

    // Summary
    console.log("\n📊 SUMMARY:");
    console.log("=" .repeat(50));

    if (missingTables.length > 0) {
        console.log(`❌ Missing tables (${missingTables.length}): ${missingTables.join(', ')}`);
    }

    if (tablesWithoutPrivileges.length > 0) {
        console.log(`❌ Tables without SELECT privileges (${tablesWithoutPrivileges.length}): ${tablesWithoutPrivileges.join(', ')}`);
    }

    if (tablesWithPrivileges.length > 0) {
        console.log(`✅ Tables with correct privileges (${tablesWithPrivileges.length}): ${tablesWithPrivileges.join(', ')}`);
    }

    const allGood = missingTables.length === 0 && tablesWithoutPrivileges.length === 0;

    if (allGood) {
        console.log("\n🎉 All DataStream privileges are correctly configured!");
    } else {
        console.log("\n⚠️  DataStream privileges need attention. See issues above.");
    }

} catch (error) {
    console.error("❌ Error checking privileges:", error.message);
} finally {
    await superuserPool.end();
    connector.close();
}