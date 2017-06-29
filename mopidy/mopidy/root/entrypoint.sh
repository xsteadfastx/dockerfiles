#!/bin/sh

set -e

if [ "$1" = "mopidy" ];then
        exec su-exec mopidy mopidy
fi

exec "$@"
