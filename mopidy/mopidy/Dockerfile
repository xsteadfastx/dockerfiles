FROM alpine:edge

ENV LANG C.UTF-8
ENV PYTHONIOENCODING UTF-8
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs

RUN set -ex \
 && addgroup -S -g 1000 mopidy \
 && adduser -S -D -h /var/lib/mopidy -s /sbin/nologin -G mopidy -g mopidy -u 1000 mopidy \
 && echo "http://nl.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
 && echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade --no-cache --available \
 && apk add --no-cache \
        ca-certificates \
        git \
        gst-plugins-bad1 \
        gst-plugins-good1 \
        gst-plugins-ugly1 \
        py-gst1 \
        py-pip \
        python \
        su-exec \
        tini \
 && pip install -U pip \
 && pip install \
        Mopidy-Internetarchive \
        Mopidy-Moped \
        Mopidy-MusicBox-Webclient \
        Mopidy-Podcast \
        Mopidy-Scrobbler \
        Mopidy-TuneIn \
        Mopidy-YouTube \
        git+https://github.com/mopidy/mopidy-soundcloud#egg=mopidy-soundcloud \
        git+https://github.com/xsteadfastx/mopidy-emby#egg=mopidy-emby \
        mopidy

ADD root /

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 6681 6600

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["mopidy"]
