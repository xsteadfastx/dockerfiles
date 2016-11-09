#!/bin/sh

if [ "$1" = "icecast" ];then
  mkfifo -m 600 /tmp/logpipe
  cat <> /tmp/logpipe 1>&2 &
  chown icecast /tmp/logpipe
  exec su-exec icecast icecast -c /etc/icecast2/icecast.xml
fi

exec "$@"
