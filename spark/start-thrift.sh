#!/usr/bin/env bash
set -euo pipefail
umask 077
cat > /opt/spark/conf/spark-defaults.conf <<EOF
spark.sql.extensions org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions
spark.sql.catalog.bench org.apache.iceberg.spark.SparkCatalog
spark.sql.catalog.bench.type rest
spark.sql.catalog.bench.uri http://lakekeeper:8181/catalog
spark.sql.catalog.bench.warehouse bench
spark.sql.catalog.bench.io-impl org.apache.iceberg.aws.s3.S3FileIO
spark.sql.catalog.bench.s3.endpoint http://lakehouse-minio:9000
spark.sql.catalog.bench.s3.path-style-access true
spark.sql.catalog.bench.s3.access-key-id ${MINIO_ROOT_USER}
spark.sql.catalog.bench.s3.secret-access-key ${MINIO_ROOT_PASSWORD}
spark.sql.catalog.bench.client.region us-east-1
spark.sql.catalog.bench.cache-enabled false
spark.sql.shuffle.partitions 4
spark.hadoop.hive.server2.thrift.bind.host 0.0.0.0
spark.hadoop.hive.server2.thrift.port 10000
spark.jars /opt/spark/iceberg-jars/iceberg-spark-runtime-3.5_2.12-1.7.1.jar,/opt/spark/iceberg-jars/iceberg-aws-bundle-1.7.1.jar
EOF
exec /opt/spark/bin/spark-submit \
  --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 \
  --master 'local[4]' \
  --driver-memory 2g
