#!/bin/sh

set -e

if [ "$1" = "upmpdcli" ];then
        exec su-exec upmpdcli upmpdcli
fi

exec "$@"
