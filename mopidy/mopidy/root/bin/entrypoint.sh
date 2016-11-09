#!/bin/sh

if [ "$1" = "mopidy" ];then
  shift
  exec gosu mopidy mopidy $@
fi

exec "$@"
