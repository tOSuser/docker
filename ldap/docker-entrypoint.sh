#!/bin/ash

#set -x

# Changing the open file descriptors limit, otherwise slapd memory
# consumption is crazy
# https://github.com/moby/moby/issues/8231
ulimit -n 1024

if [ ! -d /var/lib/openldap/data ]; then
    mkdir -p /var/lib/openldap/run
    mkdir -p /var/lib/openldap/run/ldapi
    mkdir -p /var/lib/openldap/data


    slapadd -n0 -l /tmp/config.ldif -F /etc/openldap/slapd.d/

    rm -rf /root/init.d
    mkdir /root/init.d
    if [ -d /ldap-init.d/config ]; then
        cp -ar /ldap-init.d/config  /root/init.d
    fi
    if [ -d /ldap-init.d/data ]; then
        cp -ar /ldap-init.d/data  /root/init.d
    fi

    /usr/sbin/slapd -h "ldap:/// ldaps:/// ldapi://localhost/" -d $DEBUG_LEVEL  -F /etc/openldap/slapd.d &
    sleep 3

    if [ -d /root/init.d/config ]; then
        for f in /root/init.d/config/*; do
            sed -i -e "s+%LDAP_ROOT_PASSWORD%+${LDAP_ROOT_PASSWORD//+/\\+}+g" -e "s+%LDAP_CONFIG_PASSWORD%+${LDAP_CONFIG_PASSWORD//+/\\+}+g" \
                -e "s+%LDAP_DOMAIN%+${LDAP_DOMAIN//+/\\+}+g" -e "s+%LDAP_ROOT_DN%+${LDAP_ROOT_DN//+/\\+}+g" \
                -e "s+%LDAP_ADMIN_USER%+${LDAP_ADMIN_USER//+/\\+}+g" \
                -e "s+%LDAP_BASE_GROUP%+${LDAP_BASE_GROUP//+/\\+}+g" -e "s+%LDAP_BASE_USER%+${LDAP_BASE_USER//+/\\+}+g" \
                $f
            ldapmodify -Y EXTERNAL -H ldapi://localhost/ -f $f
        done
    fi

    if [ -d /root/init.d/data ]; then
        for f in /root/init.d/data/*; do
            sed -i -e "s+%LDAP_DOMAIN%+${LDAP_DOMAIN//+/\\+}+g" -e "s+%LDAP_ROOT_DN%+${LDAP_ROOT_DN//+/\\+}+g" \
                -e "s+%LDAP_ADMIN_USER%+${LDAP_ADMIN_USER//+/\\+}+g" \
                -e "s+%LDAP_BASE_GROUP%+${LDAP_BASE_GROUP//+/\\+}+g" -e "s+%LDAP_BASE_USER%+${LDAP_BASE_USER//+/\\+}+g" \
                $f
            ldapadd -x -D $LDAP_ROOT_DN -w $LDAP_ROOT_PASSWORD -f $f
        done
    fi

    pkill slapd
    sleep 3

    #rm -rf /root/init.d
fi

# run command passed to docker run
exec "$@"