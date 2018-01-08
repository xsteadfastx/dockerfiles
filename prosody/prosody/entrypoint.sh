#!/bin/sh

set -e

if [ "$1" = "start" ];then
        chown -R prosody:prosody /etc/prosody
        chown -R prosody:prosody /var/lib/prosody
        chown -R prosody:prosody /var/log/prosody
        chown -R prosody:prosody /usr/lib/prosody-modules
        exec su-exec prosody prosody
fi

exec "$@"
