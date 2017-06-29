FROM alpine:edge

RUN set -ex \
 && addgroup -S -g 1000 mopidy \
 && adduser -S -D -h /var/lib/mopidy -s /sbin/nologin -G mopidy -g mopidy -u 1000 mopidy \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade --no-cache --available \
 && apk add --no-cache \
        snapcast \
        su-exec \
        tini \
 && mkdir /tmp/mopidy

ADD root /

EXPOSE 1704 1705

VOLUME /tmp/mopidy

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["snapserver"]
