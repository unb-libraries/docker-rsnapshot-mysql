FROM alpine:3.13
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

ENTRYPOINT ["/scripts/run.sh"]
