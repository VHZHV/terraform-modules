const qualify = (table) => `public.${table}`;

export function createPublicationSql(name, tables) {
    const target = tables === null ? "FOR ALL TABLES" : `FOR TABLE ${tables.map(qualify).join(", ")}`;
    return `DO $$
    BEGIN
      IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = '${name}') THEN
        CREATE PUBLICATION ${name} ${target};
      END IF;
    END$$;`;
}

// `existing` holds schema-qualified names as read from pg_publication_tables.
export function missingTablesSql(name, tables, existing) {
    return tables
        .filter((table) => !existing.includes(qualify(table)))
        .map((table) => `ALTER PUBLICATION ${name} ADD TABLE ${qualify(table)};`);
}
