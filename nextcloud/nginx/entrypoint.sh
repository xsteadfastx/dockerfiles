#!/bin/sh

set -e

if [ "$1" = "nginx" ];then
        echo "---> create user"
        deluser xfs
        addgroup -S -g 33 www-data
        adduser -S -h /var/www/html -H -s /sbin/nologin -u 33 -G www-data www-data

        echo "---> fix permissions"
        chown -R www-data:www-data /var/www/html

        echo "---> starting nginx"
        exec nginx -g "daemon off;"
fi

exec "$@"
