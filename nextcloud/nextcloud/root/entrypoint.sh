#!/bin/sh

if [ "$1" = "nextcloud" ];then
    chown -Rv nobody:nobody /var/www/nextcloud
    exec s6-svscan /etc/s6/
fi

exec "$@"
