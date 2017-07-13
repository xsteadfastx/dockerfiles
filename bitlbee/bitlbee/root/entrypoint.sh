#!/bin/sh

set -e

if [ "$1" = "bitlbee" ];then
    chown -R bitlbee:bitlbee /var/lib/bitlbee
    exec su-exec bitlbee bitlbee -D -n -v -P /var/run/bitlbee/bitlbee.pid
fi

exec "$@"
