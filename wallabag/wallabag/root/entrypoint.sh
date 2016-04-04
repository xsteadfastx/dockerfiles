#!/bin/sh

if [ "$1" = "wallabag" ];then
    exec s6-svscan /etc/s6/
fi

exec "$@"
