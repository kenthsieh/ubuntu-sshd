#!/bin/sh
set -e

ssh-keygen -A

if [ -n "$SSH_PUBLIC_KEY" ]; then
    printf '%s\n' "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi

if [ -n "$ROOT_PASSWORD" ]; then
    echo "root:$ROOT_PASSWORD" | chpasswd
    printf '%s\n' 'PermitRootLogin yes' 'PasswordAuthentication yes' \
        > /etc/ssh/sshd_config.d/05-password.conf
fi

exec "$@"
