FROM alpine:edge
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

COPY root /

RUN apk add --update \
      bitlbee \
      su-exec \
 && apk add --allow-untrusted /tmp/bitlbee-facebook-1.0.0-r0.apk \
 && rm -rf /var/cache/apk/* \
 && rm /tmp/bitlbee-facebook-1.0.0-r0.apk

RUN adduser -h /var/lib/bitlbee -H -s /sbin/nologin -D bitlbee

RUN mkdir /var/run/bitlbee \
 && chown bitlbee:bitlbee /var/run/bitlbee

VOLUME /data

EXPOSE 6667

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitlbee"]
