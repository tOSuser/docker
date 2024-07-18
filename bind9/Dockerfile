FROM alpine:3.12

MAINTAINER nexttop <nexttop@osxx.com>

COPY bind /opt/bind
COPY entrypoint.sh /

RUN apk update \
    && apk add \
        bind \
        nano \
        bind-tools \
    && rm -rf /var/cache/apk/* \
    && chmod +x entrypoint.sh

#VOLUME /var/named /etc/bind

EXPOSE 53/tcp 53/udp

CMD ["/entrypoint.sh"]