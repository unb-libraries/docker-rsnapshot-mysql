FROM alpine:latest
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

LABEL ca.unb.lib.daemon="nginx"
LABEL vcs-ref="alpine-edge"
LABEL vcs-url="https://github.com/unb-libraries/docker-rsnapshot-mysql"
LABEL vendor="University of New Brunswick Libraries"

ENV MYSQL_HOSTNAME localhost
ENV MYSQL_PORT 3306
ENV MYSQL_USER_NAME root
ENV MYSQL_USER_PASSWORD changeme

ENV MYSQL_DUMP_LOCATION /app/mysql_dumps

RUN apk --update add rsnapshot mysql-client && \
  touch /var/log/rsnapshot.log && \
  rm -f /var/cache/apk/* && \
  mkdir -p ${MYSQL_DUMP_LOCATION}

COPY ./conf/rsnapshot/rsnapshot.conf /etc/rsnapshot.conf

COPY scripts /scripts
RUN cp /scripts/cron/mysql_backup_hourly.sh /etc/periodic/hourly/ && \
  cp /scripts/cron/mysql_backup_daily.sh /etc/periodic/daily/ && \
  cp /scripts/cron/mysql_backup_weekly.sh /etc/periodic/weekly/ && \
  cp /scripts/cron/mysql_backup_monthly.sh /etc/periodic/monthly/

ENTRYPOINT ["/scripts/run.sh"]
