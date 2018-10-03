FROM alpine:3.8

LABEL Name="dnsmasq"
LABEL Version="0.0.0"

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        dnsmasq \
        tini

ENTRYPOINT ["/sbin/tini"]
CMD ["dnsmasq", "-k", "--log-facility=-"]
