FROM nginx:alpine-slim
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with Nginx"

# Setup document root
WORKDIR /var/www/html

RUN apk add --no-cache \
  fcgi \
  && rm -rf /var/cache/apk/*

# Configure nginx - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY config/conf.d /etc/nginx/conf.d/
COPY config/http.d /etc/nginx/http.d/

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

CMD ["nginx", "-g", "daemon off;"]