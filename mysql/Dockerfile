ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with mysql(mariadb) based on Alpine Linux."

WORKDIR /data

COPY startup.sh /startup.sh

RUN apk add --no-cache \
    bash \
    mysql \
    mysql-client \
    && rm -rf /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf

RUN set -x \
    # ---
    # Update /etc/my.cnf.d/mariadb-server.cnf with default pre-settings
    # ---
    && sed -i 's/^skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf \
    && sed -i 's/#\(bind-address\)/\1/' /etc/my.cnf.d/mariadb-server.cnf

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306

CMD ["/startup.sh"]