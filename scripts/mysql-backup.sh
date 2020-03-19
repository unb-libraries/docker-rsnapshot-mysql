#!/usr/bin/env sh
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

DATABASES=`$MYSQL -h MYSQL_HOSTNAME -P MYSQL_PORT --user=MYSQL_USER_NAME -pMYSQL_USER_PASSWORD -e "SHOW DATABASES;" | grep -Ev "^(Database|information_schema|performance_schema|sys)$"`

for DB in $DATABASES; do
  $MYSQLDUMP -h MYSQL_HOSTNAME -P MYSQL_PORT --force --events --ignore-table=mysql.event --opt --user=MYSQL_USER_NAME -pMYSQL_USER_PASSWORD --databases $DB > "/tmp/$DB"
  gzip -9 "/tmp/$DB"
  mv "/tmp/$DB.gz" "./$DB.gz"
done
