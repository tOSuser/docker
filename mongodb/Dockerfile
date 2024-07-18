ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with MongoDB based on Alpine Linux."

# Setup document root
#VOLUME ["/data/db"]
WORKDIR /data

# Install packages and remove default server definition
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache mongodb \
#   mongodb-tools \
  && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017 28017

CMD [ "mongod", "--bind_ip", "0.0.0.0" ]
