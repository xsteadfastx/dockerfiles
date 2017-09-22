FROM alpine:edge
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

COPY root /

RUN set -ex \
 && apk upgrade -a --no-cache \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --no-cache \
      bitlbee \
      bitlbee-facebook@testing \
      bitlbee-otr \
      su-exec \
      tini \
 && adduser -h /var/lib/bitlbee -H -s /sbin/nologin -D bitlbee \
 && mkdir -p /var/run/bitlbee \
 && chown bitlbee:bitlbee /var/run/bitlbee

VOLUME /data

EXPOSE 6667

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["bitlbee"]
