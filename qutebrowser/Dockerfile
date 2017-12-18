FROM ubuntu:artful

ENV USER_ID 1000
ENV GOSU_VERSION 1.10
ENV TINI_VERSION v0.14.0
ENV QUTE_VERSION=1.0.4

ADD https://qutebrowser.org/python3-pypeg2_2.15.2-1_all.deb /tmp/python3-pypeg2.deb
ADD https://github.com/qutebrowser/qutebrowser/releases/download/v$QUTE_VERSION/qutebrowser_$QUTE_VERSION-1_all.deb /tmp/qutebrowser.deb

RUN set -ex \
 && apt update \
 && apt install -y \
        /tmp/python3-pypeg2.deb \
        /tmp/qutebrowser.deb \
        dirmngr \
        pulseaudio \
        pulseaudio-utils \
        wget \
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
 && echo autospawn=no >> /etc/pulse/client.conf \
 && echo enable-shm=no >> /etc/pulse/client.conf \
 && rm /tmp/python3-pypeg2.deb \
 && rm /tmp/qutebrowser.deb \
 && rm -rf /var/cache/apt

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["qutebrowser"]
