#!/usr/bin/env sh
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

DATABASES=`$MYSQL -h $MYSQL_HOSTNAME --user=$MYSQL_USER_NAME -p$MYSQL_USER_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for DB in $DATABASES; do
  $MYSQLDUMP --force --events --ignore-table=mysql.event --opt --user=$MYSQL_USER_NAME -p$MYSQL_USER_PASSWORD --databases $DB | gzip > "$DB.gz"
done
