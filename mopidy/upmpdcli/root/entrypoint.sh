#!/bin/sh

if [ "$1" = "upmpdcli" ];then
        gosu upmpdcli upmpdcli
fi

exec "$@"
