FROM ubuntu:xenial

ENV GOSU_VERSION 1.10

RUN set -ex \
 && apt-get update \
 && apt-get install -y \
        ca-certificates \
        wget \
 && cd /tmp \
 && wget https://download2.ebz.epson.net/iscan/plugin/gt-x750/deb/x64/iscan-gt-x750-bundle-1.0.0.x64.deb.tar.gz \
 && tar xvfz iscan-gt-x750-bundle-1.0.0.x64.deb.tar.gz \
 && iscan-gt-x750-bundle-1.0.0.x64.deb/install.sh \
 && wget https://www.hamrick.com/files/vuex6495.tgz \
 && tar xvfz vuex6495.tgz \
 && cp VueScan/* /usr/local/bin/ \
 && rm -rf /tmp/* \
 && rm -rf /var/lib/apt/lists/* \
 && cd /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["vuescan"]
