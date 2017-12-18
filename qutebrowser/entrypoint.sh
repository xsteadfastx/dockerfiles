#!/bin/sh

if [ "$1" = "qutebrowser" ];then
    echo "---> create user"
    useradd -u $USER_ID -m qutebrowser
    echo "---> export env variables"
    export PULSE_SERVER=unix:/run/pulse/native
    export PULSE_COOKIE=/tmp/pulse_cookie
    echo "---> start qutebrowser"
    exec gosu qutebrowser qutebrowser
fi

exec "$@"
