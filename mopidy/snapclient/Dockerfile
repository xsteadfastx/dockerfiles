FROM debian:jessie

ENV GOSU_VERSION 1.10
ENV TINI_VERSION v0.14.0
ENV USER_ID 1000
ENV SNAPSERVER localhost

RUN set -ex \
 && apt-get update \
 && apt-get install -y \
        ca-certificates \
        init-system-helpers \
        libavahi-client3 \
        libavahi-common3 \
        pulseaudio \
        pulseaudio-utils \
        wget\
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -O /sbin/tini \
 && wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc -O /sbin/tini.asc \
 && cat /sbin/tini.asc \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --batch --verify /sbin/tini.asc /sbin/tini \
 && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc /sbin/tini.asc \
 && chmod +x /sbin/tini \
 && wget https://github.com/badaix/snapcast/releases/download/v0.11.1/snapclient_0.11.1_amd64.deb -O /tmp/snapclient.deb \
 && dpkg -i /tmp/snapclient.deb \
 && rm /tmp/snapclient.deb \
 && echo autospawn=no >> /etc/pulse/client.conf \
 && echo enable-shm=no >> /etc/pulse/client.conf \
 && apt-get purge -y --auto-remove \
        ca-certificates \
        wget \
 && rm -rf /var/cache/apt

ADD root /

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["snapclient"]
