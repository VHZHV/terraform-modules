import pg from "pg";
import { Connector } from "@google-cloud/cloud-sql-connector";

const { Pool } = pg;

const connector = new Connector();
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

await Promise.all(
  process.env.EXTRA_COMMANDS.split(";")
    .filter((o) => o !== "")
    .map((command) =>
      pool.query(
        `${command.replaceAll("APP_USERNAME", `"${process.env.APP_USERNAME}"`)};`,
      )
    )
);
await pool.query(
  `GRANT pg_read_all_data, pg_write_all_data TO "${process.env.APP_USERNAME}";`,
);

await pool.query(
  `GRANT pg_read_all_data, pg_write_all_data TO "${process.env.USER_NAME}";`,
);

await pool.end();
connector.close();
