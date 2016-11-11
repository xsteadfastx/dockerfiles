#!/bin/sh

if [ "$1" = "mopidy" ];then
  chown mopidy:audio /var/lib/mopidy
  gosu mopidy mopidy local scan
  exec gosu mopidy mopidy
fi

exec "$@"
