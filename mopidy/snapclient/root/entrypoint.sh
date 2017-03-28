#!/bin/sh

if [ "$1" = "snapclient" ];then
    echo "===> create user"
    useradd -u $USER_ID -m snap
    echo "===> export env variables"
    export PULSE_SERVER=unix:/run/pulse/native
    export PULSE_COOKIE=/tmp/pulse_cookie
    echo "===> start snapclient"
    gosu snap snapclient -h $SNAPSERVER
fi

exec "$@"
