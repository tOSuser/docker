#!/bin/sh

# copy conf.d files from /opt/nginx to /etc/nginx if there is no conf file
#if [ ! -f /etc/nginx/conf.d/default.conf ]; then
#	cp -r /opt/nginx/conf.d/* /etc/nginx/conf.d/
#fi

# copy http.d files from /opt/nginx to /etc/nginx if there is no conf file
#if [ ! -f /etc/nginx/http.d/default.conf ]; then
#	cp -r /opt/nginx/http.d /etc/nginx/
#fi

# copy www files from www to /etc/nginx if there is no conf file
#if [ ! -f /var/www/html/index.html ]; then
#	cp -r /opt/nginx/www/* /var/www/html/
#fi

# Run Nginx
exec "$@"
