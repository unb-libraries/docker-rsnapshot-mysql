#!/usr/bin/env sh
MYDUMPER=/usr/bin/mydumper
ROWS_PER_FILE='500000'

TMP_DIR=$(mktemp -d -t sqldumps-XXXXXXXXXX)

$MYDUMPER \
  --host=MYSQL_HOSTNAME \
  --port=MYSQL_PORT \
  --user=MYSQL_USER_NAME \
  --password=MYSQL_USER_PASSWORD \
  --regex="^(?!(Database|information_schema|performance_schema|sys|mysql))$" \
  --outputdir=$TMP_DIR \
  --rows=100000 \
  --compress \
  --build-empty-files \
  --compress-protocol

mv "$TMP_DIR/*" .
rm -rf $TMP_DIR
