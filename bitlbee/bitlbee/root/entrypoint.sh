#!/bin/sh

set -e

if [ "$1" = "bitlbee" ];then
    chown -R bitlbee:bitlbee /var/lib/bitlbee
    chown -R bitlbee:bitlbee /var/run/bitlbee
    exec gosu bitlbee bitlbee -F -n -v -P /var/run/bitlbee/bitlbee.pid
fi

exec "$@"
