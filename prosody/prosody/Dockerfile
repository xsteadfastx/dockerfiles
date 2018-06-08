FROM alpine:edge

LABEL name=prosody
      version="0.0.0"

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        busybox-extras \
        prosody \
        su-exec \
        tini

ADD entrypoint.sh /entrypoint.sh

EXPOSE 80 443 5222 5269 5347 5280 5281

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["start"]
