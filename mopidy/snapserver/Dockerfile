FROM alpine:edge

RUN set -ex \
 && addgroup -S -g 1000 mopidy \
 && adduser -S -D -h /var/lib/mopidy -s /sbin/nologin -G mopidy -g mopidy -u 1000 mopidy \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --no-cache \
        snapcast \
        su-exec \
 && mkdir /tmp/mopidy

EXPOSE 1704 1705

VOLUME /tmp/mopidy

CMD set -ex; chown -Rv mopidy:mopidy /tmp/mopidy && su-exec mopidy snapserver -s "pipe:///tmp/mopidy/snapfifo?name=mopidy&codec=flac"
