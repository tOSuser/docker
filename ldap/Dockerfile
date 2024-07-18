ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}
MAINTAINER nexttop <nexttop@osxx.com>
LABEL Description="Lightweight container with ldap based on Alpine Linux."

ENV DEBUG_LEVEL=256
ENV LDAP_ADMIN_USER="admin"
ENV LDAP_BASE_GROUP="tgroups"
ENV LDAP_BASE_USER="tpeople"
ENV LDAP_DOMAIN="dc=mydomain,dc=se"
ENV LDAP_ROOT_DN="cn=admin,dc=mydomain,dc=se"
ENV LDAP_ROOT_PASSWORD="secret"
ENV LDAP_CONFIG_PASSWORD="secret"

# Install packages and remove default server definition
RUN apk update && \
  apk add --no-cache \
  curl \
  openldap \
  openldap-clients \
  openldap-overlay-memberof \
  openldap-overlay-refint \
  openldap-overlay-ppolicy \
  openldap-back-mdb \
  openldap-back-monitor \
  && mkdir -p /run/openldap /var/lib/openldap/openldap-data \
  && rm -rf /var/cache/apk/*

RUN mkdir /etc/openldap/slapd.d && \
  mkdir /var/lib/openldap/run/ && \
  mkdir /var/lib/openldap/run/ldapi && \
  mkdir /ldap-init.d /ldap-init.d/config /ldap-init.d/data
VOLUME ["/ldap-init.d","/var/lib/openldap"]

COPY init/config/* /ldap-init.d/config/
COPY init/data/* /ldap-init.d/data/

COPY config.ldif /tmp/config.ldif
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

#VOLUME ["/ldif", "/var/lib/openldap/openldap-data"]

EXPOSE 389
#EXPOSE 636

CMD ["/usr/sbin/slapd","-h","ldap:/// ldaps:/// ldapi://localhost/","-d","256","-F","/etc/openldap/slapd.d"]
