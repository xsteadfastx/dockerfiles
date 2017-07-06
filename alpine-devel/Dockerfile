FROM alpine:edge

RUN apk upgrade -a --no-cache

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
