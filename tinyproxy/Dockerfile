FROM alpine:3.8

LABEL Name="tinyproxy"
LABEL Version="0.0.0"

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        tini \
        tinyproxy

EXPOSE 8888

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["tinyproxy", "-d"]
