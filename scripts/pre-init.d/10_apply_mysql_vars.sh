#!/usr/bin/env sh
sed -i "s|MYSQL_DUMP_LOCATION|$MYSQL_DUMP_LOCATION|g" /etc/rsnapshot.conf
