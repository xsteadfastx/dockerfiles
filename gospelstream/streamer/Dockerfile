FROM debian:stretch-slim

ENV TINI_VERSION v0.16.1
ENV GOSU_VERSION 1.10

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN set -ex \
 && chmod +x /tini

RUN set -ex \
 && fetchDeps='ca-certificates dirmngr gpg wget' \
 && apt-get update \
 && apt-get install -y --no-install-recommends $fetchDeps \
 && rm -rf /var/lib/apt/lists/* \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && apt-get purge -y --auto-remove $fetchDeps

RUN set -ex \
 && apt-get update \
 && apt-get install -y \
        alsa-utils \
        liquidsoap \
        liquidsoap-plugin-alsa \
        liquidsoap-plugin-opus \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /opt/streamer \
 && usermod -G audio -a liquidsoap

COPY streamer.liq /opt/streamer/streamer.liq

ENTRYPOINT ["/tini", "--"]

CMD ["gosu", "liquidsoap", "/opt/streamer/streamer.liq"]
