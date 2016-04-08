FROM alpine:edge
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

RUN apk add --update \
      bitlbee \
      su-exec \
 && rm -rf /var/cache/apk/*

RUN adduser -h /var/lib/bitlbee -H -s /sbin/nologin -D bitlbee

COPY root /

RUN mkdir /var/run/bitlbee \
 && chown bitlbee:bitlbee /var/run/bitlbee

VOLUME /data

EXPOSE 6667

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitlbee"]
