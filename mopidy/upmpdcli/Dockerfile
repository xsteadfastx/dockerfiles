FROM alpine:edge

RUN set -ex \
 && echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        upmpdcli \
        su-exec \
        tini \
 && addgroup -S upmpdcli \
 && adduser -h /var/lib/upmpdcli -S -D -G upmpdcli upmpdcli

ENTRYPOINT ["/sbin/tini", "--", "su-exec", "upmpdcli", "upmpdcli"]
