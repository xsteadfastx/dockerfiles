FROM debian:jessie

ENV LANG C.UTF-8
ENV GOSU_VERSION 1.9

RUN apt-get update \
 && apt-get install -y wget \
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list \
 && apt-get update \
 && apt-get install -y \
        gir1.2-gst-plugins-base-1.0 \
        gir1.2-gstreamer-1.0 \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-tools \
        mopidy \
        mopidy-internetarchive \
        python-pip \
 && rm -rf /var/lib/apt/lists/* \
 && pip install \
        Mopidy-Beets \
        Mopidy-Moped \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu

COPY root /

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 6680
EXPOSE 6600

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["mopidy"]
