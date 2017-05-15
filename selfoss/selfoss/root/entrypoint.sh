#!/bin/sh

set -e

if [ "$1" = "selfoss" ];then
        ansible-playbook /etc/ansible/entrypoint.yml -c local
        exec php-fpm7
fi

exec "$@"
