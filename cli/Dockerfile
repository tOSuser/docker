ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with cli based on Alpine Linux."

# Setup document root
WORKDIR /

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  bash \
  mysql-client \
  openldap-clients \
  && rm -rf /var/cache/apk/*


COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]

