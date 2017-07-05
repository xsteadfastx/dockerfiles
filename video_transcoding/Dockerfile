FROM debian:stretch

ENV VIDEO_TRANSCODING_VERSION 0.17.3

RUN set -ex \
 && export DEBIAN_FRONTEND=noninteractive \
 && echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
            curl \
            dvdbackup \
            ffmpeg \
            git \
            gosu \
            handbrake-cli \
            libcdio-utils \
            mkvtoolnix \
            mp4v2-utils \
            mpv \
            ruby-full \
            vobcopy \
            zsh \
 && apt-get install -y libdvd-pkg \
 && dpkg-reconfigure libdvd-pkg \
 && git clone --branch $VIDEO_TRANSCODING_VERSION --depth 1 https://github.com/donmelton/video_transcoding.git /tmp/video_transcoding \
 && cd /tmp/video_transcoding \
 && gem build video_transcoding.gemspec \
 && gem install video_transcoding-$VIDEO_TRANSCODING_VERSION.gem \
 && cd / \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/video_transcoding \
 && mkdir /data

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["video_transcoding"]
