FROM alpine:edge
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

COPY root /

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
      bitlbee \
      bitlbee-facebook@testing \
      su-exec \
 && rm -rf /var/cache/apk/*

RUN adduser -h /var/lib/bitlbee -H -s /sbin/nologin -D bitlbee

RUN mkdir /var/run/bitlbee \
 && chown bitlbee:bitlbee /var/run/bitlbee

VOLUME /data

EXPOSE 6667

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitlbee"]
