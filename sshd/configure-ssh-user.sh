#!/bin/bash

# Set default values for SSH_USERNAME and PASSWORD if not provided
#: ${SSH_USERNAME:=sshuser}
#: ${SSH_PASSWORD:=sshpass}
: ${ROOT_PASSWORD:=rootpass}

# Create the user with the provided username and set the password
#useradd -ms /bin/bash $SSH_USERNAME
#echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

# Set the root password for the SSH server (CHANGE THIS PASSWORD!)
echo "root:$ROOT_PASSWORD" | chpasswd

# Set the authorized keys from the AUTHORIZED_KEYS environment variable (if provided)
#if [ -n "$AUTHORIZED_KEYS" ]; then
#    mkdir -p /home/$SSH_USERNAME/.ssh
#    echo "$AUTHORIZED_KEYS" > /home/$SSH_USERNAME/.ssh/authorized_keys
#    chown -R $SSH_USERNAME:$SSH_USERNAME /home/$SSH_USERNAME/.ssh
#fi

# Start the SSH server
/usr/sbin/sshd -D
