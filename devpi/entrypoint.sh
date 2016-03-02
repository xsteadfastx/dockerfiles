#!/bin/sh

if [ "$1" = "devpi-server" ];then
    chown -R devpi /data
    exec gosu devpi devpi-server --host 0.0.0.0 --port 3141 --serverdir /data
fi

exec "$@"
