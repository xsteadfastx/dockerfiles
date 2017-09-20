#!/bin/sh

set -e

if [ "$1" = "gospelplayer" ]; then

        echo "---> group modifications"
        AUDIO_GID=${AUDIO_GID:-29}
        groupmod -g "$AUDIO_GID" audio

        echo "---> adding user"
        USER_ID=${USER_ID:-1000}
        GROUP_ID=${GROUP_ID:-1000}
        useradd --system --no-create-home --uid "$USER_ID" --groups audio mplayer

        echo "---> start mplayer"
        exec gosu mplayer mplayer -ao pulse -loop 0 -cache 100 "$STREAM"

fi

exec "$@"

