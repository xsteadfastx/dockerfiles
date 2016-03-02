#!/bin/sh

if [ "$1" = "owncloud" ];then
    chown -Rv nobody:nobody /var/www/owncloud
    exec s6-svscan /etc/s6/
fi

exec "$@"
