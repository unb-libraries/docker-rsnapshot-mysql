#!/usr/bin/env sh
touch /var/log/rsnapshot.log
touch /etc/cron.hourly/mysql_backup_hourly
touch /etc/cron.daily/mysql_backup_daily
touch /etc/cron.weekly/mysql_backup_weekly
touch /etc/cron.monthly/mysql_backup_monthly
