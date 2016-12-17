#!/bin/sh

if [ "$1" = "upmdcli" ];then
        gosu nobody upmdcli
fi

exec "$@"
