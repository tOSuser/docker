ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with Nginx based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  supervisor \
  && rm -rf /var/cache/apk/*

# Configure nginx - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY config/conf.d /etc/nginx/conf.d/
COPY config/http.d /etc/nginx/http.d/

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

# Create a copy if default server files
RUN cp -r /etc/nginx /opt/
RUN mkdir /opt/nginx/www
COPY www/html/ /opt/nginx/www/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Add application
COPY www/html/ /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping || exit 1
