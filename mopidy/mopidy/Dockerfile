FROM debian:jessie

ENV LANG C.UTF-8
ENV SNAPCASTVERSION 0.10.0

RUN apt-get update \
 && apt-get install -y wget \
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list \
 && apt-get update \
 && apt-get install -y \
        gir1.2-gst-plugins-base-1.0 \
        gir1.2-gstreamer-1.0 \
        git \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-tools \
        mopidy \
        mopidy-internetarchive \
        mopidy-scrobbler \
        python-pip \
        supervisor \
 && wget 'https://github.com/badaix/snapcast/releases/download/v'$SNAPCASTVERSION'/snapserver_'$SNAPCASTVERSION'_amd64.deb' \
 && dpkg -i --force-all 'snapserver_'$SNAPCASTVERSION'_amd64.deb' \
 && apt-get -f install -y \
 && rm 'snapserver_'$SNAPCASTVERSION'_amd64.deb' \
 && rm -rf /var/lib/apt/lists/* \
 && pip install -U pip \
 && pip install \
        Mopidy-Beets \
        Mopidy-MusicBox-Webclient \
        Mopidy-Moped \
        Mopidy-TuneIn \
        git+https://github.com/mopidy/mopidy-soundcloud#egg=mopidy-soundcloud \
        git+https://github.com/xsteadfastx/mopidy-emby#egg=mopidy-emby

COPY root /

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 1704 1705 6680 6600

CMD chown mopidy:audio /var/lib/mopidy && chown -R mopidy:audio /var/lib/mopidy/.config && /usr/bin/supervisord -c /etc/supervisord.conf
