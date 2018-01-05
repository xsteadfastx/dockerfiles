#!/bin/sh

set -e

if [ "$1" = "start" ];then
        exec su-exec prosody prosody
fi

exec "$@"
