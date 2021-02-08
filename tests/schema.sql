CREATE TABLE IF NOT EXISTS "nodes" (
	"body"	TEXT,
	"id"	TEXT NOT NULL GENERATED ALWAYS AS (json_extract("body", '$.id')) VIRTUAL
);
CREATE TABLE IF NOT EXISTS "edges" (
	"source"	TEXT,
	"target"	TEXT,
	"properties"	TEXT,
	FOREIGN KEY("target") REFERENCES "nodes"("id"),
	FOREIGN KEY("source") REFERENCES "nodes"("id")
);
CREATE INDEX IF NOT EXISTS "id_idx" ON "nodes" (
	"id"
);
CREATE INDEX IF NOT EXISTS "source_idx" ON "edges" (
	"source"
);
CREATE INDEX IF NOT EXISTS "target_idx" ON "edges" (
	"target"
);