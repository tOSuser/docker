ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with PHP 8.3 based on Alpine Linux."

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  php83 \
  php83-ctype \
  php83-curl \
  php83-dom \
  php83-fileinfo \
  php83-fpm \
  php83-gd \
  php83-intl \
  php83-mbstring \
  php83-mysqli \
  php83-pdo_mysql \
  php83-pgsql \
  php83-pdo_pgsql \
  php83-sqlite3 \
  php83-pdo_sqlite \
  php83-openssl \
  php83-phar \
  php83-session \
  php83-tokenizer \
  php83-xml \
  php83-xmlreader \
  php83-xmlwriter \
  php83-zip \
  php83-iconv \
  php83-simplexml \
  php83-pdo \
  php83-ldap \
  php83-imap \
  php83-json \
  php83-gmp \
  php83-cli \
  supervisor \
  && rm -rf /var/cache/apk/*

# Configure PHP-FPM
ENV PHP_INI_DIR /etc/php83
#Remove useless config
RUN rm -rf ${PHP_INI_DIR}/php-fpm.d

COPY config/php.ini         ${PHP_INI_DIR}/php.ini
COPY config/php-fpm.conf    ${PHP_INI_DIR}/php-fpm.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create symlink for php
RUN ln -s /usr/bin/php83 /usr/bin/php

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Switch to use a non-root user from here on
USER nobody

# Expose the port nginx is reachable on
EXPOSE 9000

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:9000/fpm-ping || exit 1
