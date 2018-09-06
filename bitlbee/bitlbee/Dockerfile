FROM alpine:edge

LABEL name="bitlbee"
LABEL version="0.0.0"
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

COPY root /

RUN set -ex \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
      bitlbee \
      bitlbee-facebook \
      bitlbee-otr \
      su-exec \
      tini \
 && apk add --no-cache --virtual build-deps \
      alpine-sdk \
      autoconf \
      automake \
      bitlbee-dev \
      git \
      libtool \
 && git clone https://alexschroeder.ch/cgit/bitlbee-mastodon /tmp/mastodon \
 && cd /tmp/mastodon \
 && ./autogen.sh \
 && ./configure \
 && make \
 && make install \
 && cd / \
 && rm -rf /tmp/mastodon \
 && apk del build-deps \
 && addgroup -S bitlbee \
 && adduser -S -H -D -h /var/lib/bitlbee -G bitlbee bitlbee \
 && mkdir -p /var/run/bitlbee

VOLUME /data

EXPOSE 6667

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["bitlbee"]
