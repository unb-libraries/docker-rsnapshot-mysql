FROM ubuntu:focal
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

LABEL ca.unb.lib.daemon="mysql"
LABEL vcs-ref="debian"
LABEL vcs-url="https://github.com/unb-libraries/docker-rsnapshot-mysql"
LABEL vendor="University of New Brunswick Libraries"

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_HOSTNAME localhost
ENV MYSQL_PORT 3306
ENV MYSQL_USER_NAME root
ENV MYSQL_USER_PASSWORD changeme

ENV MYSQL_DUMP_LOCATION /app/mysql_dumps

RUN apt-get update && apt-get --yes install \
    coreutils \
    curl \
    libatomic1 \
    libglib2.0-dev \
    mysql-client \
    rsnapshot && \
  rm -rf /var/lib/apt/lists/* && \
  curl -sLO https://github.com/maxbube/mydumper/releases/download/v0.9.5/mydumper_0.9.5-2.stretch_amd64.deb && dpkg -i mydumper_0.9.5-2.stretch_amd64.deb && rm -f mydumper_0.9.5-2.stretch_amd64.deb && \
  touch /var/log/rsnapshot.log && \
  mkdir -p ${MYSQL_DUMP_LOCATION}

COPY ./conf/rsnapshot/rsnapshot.conf /etc/rsnapshot.conf
COPY scripts /scripts

RUN cp /scripts/cron/mysql_backup_hourly.sh /etc/cron.hourly/mysql_backup_hourly && \
  cp /scripts/cron/mysql_backup_daily.sh /etc/cron.daily/mysql_backup_daily && \
  cp /scripts/cron/mysql_backup_weekly.sh /etc/cron.weekly/mysql_backup_weekly && \
  cp /scripts/cron/mysql_backup_monthly.sh /etc/cron.monthly/mysql_backup_monthly

ENTRYPOINT ["/scripts/run.sh"]
