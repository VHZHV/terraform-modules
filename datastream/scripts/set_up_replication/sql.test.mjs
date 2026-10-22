import test from "node:test";
import assert from "node:assert/strict";
import {createPublicationSql, missingTablesSql} from "./sql.mjs";

test("null tables publishes all tables", () => {
    assert.ok(createPublicationSql("p", null).includes("FOR ALL TABLES"));
});

test("table list publishes schema-qualified tables", () => {
    assert.ok(createPublicationSql("p", ["a", "b"]).includes("FOR TABLE public.a, public.b"));
});

test("missing tables get one ALTER each", () => {
    assert.deepEqual(missingTablesSql("p", ["a", "b"], ["public.a"]), [
        "ALTER PUBLICATION p ADD TABLE public.b;",
    ]);
});
