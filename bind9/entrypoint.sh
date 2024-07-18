#!/bin/sh
if [ ! -d /var/named ]; then
    mkdir -p /var/named
    chown -R named /var/named
fi

if [ ! -f /etc/bind/named.conf ]; then
    cp -a /opt/bind/* /etc/bind
    chown -R named /etc/bind/rndc.key
fi

named -c /etc/bind/named.conf -g -u named