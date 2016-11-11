#!/bin/sh

if [ "$1" = "mopidy" ];then
  chown mopidy:audio /var/lib/mopidy

  # print full config
  gosu mopidy mopidy config

  # scan for local music
  gosu mopidy mopidy local scan

  # run mopidy
  exec gosu mopidy mopidy
fi

exec "$@"
