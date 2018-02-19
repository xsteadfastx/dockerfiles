#!/bin/sh

set -e

if [ "$1" = "nginx" ];then
        echo "---> create user"
        if grep -q :33: /etc/passwd > /dev/null 2>&1; then
                sed -i "/:33:/d" /etc/passwd
                sed -i "/:33:/d" /etc/shadow
        fi
        if grep -q :33: /etc/group > /dev/null 2>&1; then
                sed -i "/:33:/d" /etc/group
        fi
        addgroup -S -g 33 www-data
        adduser -S -h /var/www/html -H -s /sbin/nologin -u 33 -G www-data www-data

        echo "---> fix permissions"
        chown -R www-data:www-data /var/www/html

        echo "---> starting nginx"
        exec nginx -g "daemon off;"
fi

exec "$@"
