-- Executed with Spark SQL through Beeline / Spark Thrift Server.
SELECT 'customer' AS table_name, count(*) AS rows FROM bench.bronze.customer
UNION ALL SELECT 'orders', count(*) FROM bench.bronze.orders
UNION ALL SELECT 'lineitem', count(*) FROM bench.bronze.lineitem
UNION ALL SELECT 'nation', count(*) FROM bench.bronze.nation;

SELECT c.custkey, c.name, n.name AS nation
FROM bench.bronze.customer c
JOIN bench.bronze.nation n ON c.nationkey = n.nationkey
ORDER BY c.custkey LIMIT 5;

SELECT count(*) AS restored_rows, count(quality_note) AS filled_notes
FROM bench.silver.q10_evolution_demo;
SELECT custkey, name, nation, quality_note
FROM bench.silver.q10_evolution_demo ORDER BY custkey LIMIT 3;
