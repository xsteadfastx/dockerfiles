FROM alpine:3.6

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        mplayer \
        shadow \
        su-exec \
        tini \
 && groupmod -g 29 audio \
 && adduser -S -H -D -G audio mplayer

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["su-exec", "mplayer", "mplayer", "-loop", "0", "http://192.168.10.63:8000/live"]
