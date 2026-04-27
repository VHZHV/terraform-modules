import pg from "pg";
import {Connector, GoogleAuth} from "@google-cloud/cloud-sql-connector";

const {Pool} = pg;

const connector = new Connector({
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
});
const pool = new Pool({
    ...clientOpts,
    user: process.env.USER_NAME,
    password: process.env.USER_PASSWORD,
    database: process.env.DATABASE_NAME,
    max: 5,
});

process.env.EXTRA_COMMANDS.split(";")
    .filter((o) => o !== "")
    .forEach(async (command) => {
        await pool.query(
            `${command.replaceAll("APP_USERNAME", `"${process.env.APP_USERNAME}"`)};`,
        );
    });
await pool.query(
    `GRANT pg_read_all_data, pg_write_all_data TO "${process.env.APP_USERNAME}";`,
);

await pool.query(
    `GRANT pg_read_all_data, pg_write_all_data TO "${process.env.USER_NAME}";`,
);

await pool.end();
connector.close();
