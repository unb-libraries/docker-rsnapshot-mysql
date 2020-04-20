#!/usr/bin/env bash
MYDUMPER=/usr/bin/mydumper
MYSQL=/usr/bin/mysql
ROWS_PER_FILE='100000'

TMP_DIR=$(mktemp -d -t sqldumps-XXXXXXXXXX)
DATABASES=$($MYSQL -h MYSQL_HOSTNAME -P MYSQL_PORT --user=MYSQL_USER_NAME -pMYSQL_USER_PASSWORD -e "SHOW DATABASES;" | grep -Ev "^(Database|information_schema|performance_schema|sys)$")

for DB in $DATABASES; do
  OUTPUT_DIR="$TMP_DIR/$DB"
  mkdir "$OUTPUT_DIR"
  $MYDUMPER \
    --host=MYSQL_HOSTNAME \
    --port=MYSQL_PORT \
    --user=MYSQL_USER_NAME \
    --password=MYSQL_USER_PASSWORD \
    --database=$DB \
    --outputdir=$OUTPUT_DIR \
    --rows=$ROWS_PER_FILE \
    --trx-consistency-only \
    --less-locking \
    --compress \
    --events \
    --routines \
    --build-empty-files \
    --verbose=1 \
    --compress-protocol
done

mv $TMP_DIR ./mysql
