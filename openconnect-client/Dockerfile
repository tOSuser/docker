FROM debian:buster-slim

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH server and clean up
RUN apt-get update \
    && apt-get install -y openconnect curl\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

#WORKDIR /etc/openconnect
#CMD [ "openconnect" ]

#COPY  entrypoint.sh /
#EXPOSE 22

#VOLUME ["/vpn", "/etc/openconnect"]

#ENTRYPOINT ["/entrypoint.sh"]
COPY docker-entrypoint.sh /entrypoint.sh

#EXPOSE 443/tcp
#EXPOSE 443/udp

ENTRYPOINT ["sh", "/entrypoint.sh"]
