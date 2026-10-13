-- Commands executed for the demonstration. The table already exists after execution.
-- Run creation only on a fresh table. Snapshot IDs are specific to this table.
CREATE TABLE bench.silver.q10_evolution_demo WITH (format='PARQUET')
AS SELECT * FROM bench.silver.customer_nation ORDER BY custkey LIMIT 10;
ALTER TABLE bench.silver.q10_evolution_demo ADD COLUMN note VARCHAR;
ALTER TABLE bench.silver.q10_evolution_demo RENAME COLUMN note TO quality_note;
SELECT count(*), count(quality_note) FROM bench.silver.q10_evolution_demo;

SELECT snapshot_id FROM bench.silver."q10_evolution_demo$snapshots"
ORDER BY committed_at DESC;
DELETE FROM bench.silver.q10_evolution_demo WHERE custkey IN (1, 2, 3);
SELECT count(*) FROM bench.silver.q10_evolution_demo;
SELECT count(*) FROM bench.silver.q10_evolution_demo FOR VERSION AS OF 2492711815277284993;
ALTER TABLE bench.silver.q10_evolution_demo EXECUTE rollback_to_snapshot(2492711815277284993);
SELECT count(*) FROM bench.silver.q10_evolution_demo;
