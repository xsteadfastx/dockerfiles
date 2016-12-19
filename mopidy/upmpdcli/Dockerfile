FROM debian:jessie

ENV GOSU_VERSION 1.9

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && gpg --keyserver pool.sks-keyservers.net --recv-key '4C6E 80B6 374D CD5F 53AB 706A 32D9 C2A8 35ED 066C' \
 && gpg --keyserver pool.sks-keyservers.net --recv-key 'F8E3 3472 5692 2A8A E767 605B 7808 CE96 D38B 9201' \
 && gpg --export '32D9C2A835ED066C' | apt-key add - \
 && gpg --export '7808CE96D38B9201' | apt-key add - \
 && echo "deb http://www.lesbonscomptes.com/upmpdcli/downloads/debian-jessie/ unstable main" > /etc/apt/sources.list.d/upmpdcli.list \
 && echo "deb-src http://www.lesbonscomptes.com/upmpdcli/downloads/debian-jessie/ unstable main" >> /etc/apt/sources.list.d/upmpdcli.list \
 && useradd -m upmpdcli \
 && apt-get update \
 && apt-get install -y \
        upmpdcli \
 && rm -rf /var/lib/apt/lists/*

COPY root /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["upmpdcli"]
