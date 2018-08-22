#!/bin/sh

set -e

if [ "$1" = "bitlbee" ];then
    chown -R bitlbee:bitlbee /etc/bitlbee/bitlbee.conf
    chown -R bitlbee:bitlbee /var/lib/bitlbee
    chown -R bitlbee:bitlbee /var/run/bitlbee
    exec su-exec bitlbee bitlbee -F -n -v -P /var/run/bitlbee/bitlbee.pid
fi

exec "$@"
