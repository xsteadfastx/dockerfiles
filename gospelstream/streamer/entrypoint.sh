#!/bin/sh

set -e

if [ "$1" = "streamer" ]; then

        echo "---> create directories"
        mkdir -p /var/log/liquidsoap

        echo "---> user modifications"
        USER_ID=${USER_ID:-1000}
        GROUP_ID=${GROUP_ID:-1000}

        usermod -u "$GROUP_ID" liquidsoap
        groupmod -g "$GROUP_ID" liquidsoap
        usermod -G audio -a liquidsoap

        echo "---> fix permissions"
        chown -R liquidsoap:liquidsoap /var/log/liquidsoap
        chown -R liquidsoap:liquidsoap /usr/share/liquidsoap
        chown -R liquidsoap:liquidsoap /archive

        echo "---> start liquidsoap"
        exec gosu liquidsoap /opt/streamer/streamer.liq

fi

exec "$@"
