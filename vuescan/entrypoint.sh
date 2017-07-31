#!/bin/sh

set -e

if [ "$1" = "vuescan" ];then

        echo "---> starting vuescan"
        vuescan

        echo "---> fix permissions"
        chown -R $USERID:$GROUPID /root/Scan
        chown -R $USERID:$GROUPID /root/.vuescan
        chown $USERID:$GROUPID /root/.vuescanrc
        exit

fi

exec "$@"
