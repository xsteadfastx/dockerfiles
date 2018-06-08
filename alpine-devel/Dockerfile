FROM alpine:edge

LABEL name=alpine-devel \
      version="0.0.0"

RUN apk upgrade -a --no-cache

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
