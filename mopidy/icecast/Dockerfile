FROM alpine:3.6

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        icecast \
        su-exec \
        tini \
 && mkdir -p /etc/icecast

COPY mime.types /etc/mime.types
COPY icecast.xml /etc/icecast/icecast.xml
COPY silence.mp3 /usr/share/icecast/web/silence.mp3

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["su-exec", "icecast", "icecast", "-c", "/etc/icecast/icecast.xml"]
