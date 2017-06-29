#!/bin/sh

set -e

if [ "$1" = "snapserver" ];then
        chown -R mopidy:mopidy /tmp/mopidy
        exec su-exec mopidy snapserver -s "pipe:///tmp/mopidy/snapfifo?name=mopidy&codec=flac"
fi

exec "$@"
