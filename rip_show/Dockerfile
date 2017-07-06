FROM debian:stretch

ENV LANG C.UTF-8
ENV VIDEO_TRANSCODING_VERSION 0.17.3

RUN set -ex \
 && export DEBIAN_FRONTEND=noninteractive \
 && echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        curl \
        dvdbackup \
        ffmpeg \
        git \
        gosu \
        handbrake-cli \
        libcdio-utils \
        libtesseract-dev \
        libtiff5-dev \
        mencoder \
        mkvtoolnix \
        mp4v2-utils \
        mpv \
        pkg-config \
        python3 \
        ruby-full \
        tesseract-ocr-deu \
        tesseract-ocr-eng \
        vobcopy \
        zsh \
 && apt-get install -y libdvd-pkg \
 && dpkg-reconfigure libdvd-pkg \
 && git clone --branch $VIDEO_TRANSCODING_VERSION --depth 1 https://github.com/donmelton/video_transcoding.git /tmp/video_transcoding \
 && cd /tmp/video_transcoding \
 && gem build video_transcoding.gemspec \
 && gem install video_transcoding-$VIDEO_TRANSCODING_VERSION.gem \
 && cd / \
 && git clone --depth 1 https://github.com/ruediger/VobSub2SRT.git /tmp/vobsub2srt \
 && cd /tmp/vobsub2srt \
 && ./configure \
 && make \
 && make install \
 && cd / \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/video_transcoding \
 && rm -rf /tmp/vobsub2srt \
 && mkdir /data

COPY rip_show /tmp/rip_show

RUN set -ex \
 && curl https://bootstrap.pypa.io/get-pip.py | python3 \
 && pip3 install /tmp/rip_show \
 && rm -rf /tmp/rip_show

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["rip_show"]
