#!/bin/bash
docker run --rm -ti -v /run/user/$UID/pulse:/run/pulse -v $HOME/.config/pulse/cookie:/tmp/pulse_cookie -e "SNAPSERVER=192.168.39.115" snapclient snapclient
