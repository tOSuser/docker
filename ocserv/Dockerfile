FROM alpine:3.12

MAINTAINER nexttop <nexttop@osxx.com>

ENV OC_VERSION=1.3.0

RUN buildDeps=" \
		curl \
		g++ \
		gnutls-dev \
		gpgme \
		libev-dev \
		libnl3-dev \
		libseccomp-dev \
		linux-headers \
		linux-pam-dev \
		lz4-dev \
                lz4-libs \
		make \
		readline-dev \
		tar \
		xz \
	"; \
	set -x \
	&& apk add --update --virtual .build-deps $buildDeps \
	&& curl -SL "ftp://ftp.infradead.org/pub/ocserv/ocserv-$OC_VERSION.tar.xz" -o ocserv.tar.xz \
	&& curl -SL "ftp://ftp.infradead.org/pub/ocserv/ocserv-$OC_VERSION.tar.xz.sig" -o ocserv.tar.xz.sig \
	&& gpg --keyserver pgp.mit.edu --recv-key 7F343FA7 \
	&& gpg --keyserver pgp.mit.edu --recv-key 96865171 \
	&& gpg --verify ocserv.tar.xz.sig \
	&& mkdir -p /usr/src/ocserv \
	&& tar -xf ocserv.tar.xz -C /usr/src/ocserv --strip-components=1 \
	&& rm ocserv.tar.xz* \
	&& cd /usr/src/ocserv \
	&& ./configure \
	&& make \
	&& make install \
	&& mkdir -p /etc/ocserv \
	&& cp /usr/src/ocserv/doc/sample.config /etc/ocserv/ocserv.conf \
	&& cd / \
	&& rm -fr /usr/src/ocserv \
        && curl -SL "https://github.com/seccomp/libseccomp/releases/download/v2.4.2/libseccomp-2.4.2.tar.gz" -o libseccomp-2.4.2.tar.gz \
        && mkdir -p /usr/src/libseccomp-2 \
        && tar -xf libseccomp-2.4.2.tar.gz -C /usr/src/libseccomp-2 --strip-components=1 \
        && rm libseccomp-2.4.2.tar.gz* \
        && cd /usr/src/libseccomp-2 \
        && ./configure --prefix=/usr --disable-static \
        && make \
        && make install \
        #&& cd /usr/lib/ \
        #&& ln -s /usr/lib/libseccomp.so.2.4.2 libseccomp.so.2 \
        && cd / \
        && rm -fr /usr/src/libseccomp-2 \
	&& runDeps="$( \
		scanelf --needed --nobanner /usr/local/sbin/ocserv \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| xargs -r apk info --installed \
			| sort -u \
		)" \
	&& apk add --virtual .run-deps $runDeps gnutls-utils iptables libnl3 readline \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/*

RUN apk add lz4-libs \
        && ln -s /usr/lib/libseccomp.so.2.4.2 /usr/lib/libseccomp.so.2

# Setup config
COPY default.txt /tmp/
COPY group.template.txt /tmp/
COPY ocpasswd.txt /tmp/

RUN set -x \
	# ---
	# Update /etc/ocserv/ocserv.conf with default pre-settings
	# This section works correctly only with ocserv 1.3 conf file,
	# for other version probbly it needs to be updated.
	# ---
	&& sed -i 's/\.\/sample\.passwd/\/etc\/ocserv\/ocpasswd/' /etc/ocserv/ocserv.conf \
	#&& sed -i 's/\(max-same-clients = \)2/\110/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/\.\.\/tests/\/etc\/ocserv/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/#\(compression.*\)/\1/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/\(compression = \)false/\1true/' /etc/ocserv/ocserv.conf \
	&& sed -i '/^ipv4-network = /{s/192.168.1.0/10.10.10.0/}' /etc/ocserv/ocserv.conf \
	&& sed -i 's/#\(tunnel-all-dns = true\)/\1/' /etc/ocserv/ocserv.conf \
        && sed -i '/^dns = /{s/192.168.1.2/8.8.8.8/}' /etc/ocserv/ocserv.conf \
	&& sed -i 's/^route/#route/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/^no-route/#no-route/' /etc/ocserv/ocserv.conf \
	# ---
	# Rwemove all advanced settings (all lines after '[vhost:www.example.com]''
	# ---
	&& sed -i '/\[vhost:www.example.com\]/,$d' /etc/ocserv/ocserv.conf \
	# ---
	# Activate config-per-group and a group name default
	# ---
	&& mkdir -p /etc/ocserv/config-per-group \
	&& cp /tmp/default.txt /etc/ocserv/config-per-group/default \
	&& sed -i 's/#\(select-group-by-url.*\)/\1/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/\(select-group-by-url = \)false/\1true/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/#\(auto-select-group = true\)/\1/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/#\(config-per-group = \/etc\/ocserv\/config-per-group\/\)/\1/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/#\(default-group-config.*\)/\1/' /etc/ocserv/ocserv.conf \
	&& sed -i 's/\(default-group-config = \)\/etc\/ocserv\/defaults\/group\.conf/\1\/etc\/ocserv\/config-per-group\/default/' /etc/ocserv/ocserv.conf \
	&& rm -fr /tmp/default.txt \
	# ---
	# Create a backup of ocserv.conf & ocpasswd, they will be used by entrypoint.sh
	# ---
	&& cp /tmp/ocpasswd.txt /etc/ocserv/ocpasswd \
	&& rm -fr /tmp/ocpasswd.txt \
	&& cp /tmp/group.template.txt /etc/ocserv/group.template.txt \
	&& rm -fr /tmp/group.template.txt \
	&& cp -r /etc/ocserv /opt/

WORKDIR /etc/ocserv

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 443
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]
