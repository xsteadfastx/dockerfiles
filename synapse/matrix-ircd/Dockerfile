FROM debian:jessie

ARG RUST_VERSION=nightly
ARG GOSU_VERSION=1.9

RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
 && curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz \
 && tar -xzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz \
 && ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh --without=rust-docs \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && apt-get remove --purge -y curl wget \
 && apt-get autoremove -y \
 && rm -rf \
        rust-$RUST_VERSION-x86_64-unknown-linux-gnu \
        rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
 && useradd -ms /bin/bash  matrix

USER matrix

RUN cd /home/matrix \
 && git clone https://github.com/matrix-org/matrix-ircd.git /home/matrix/matrix-ircd \
 && cd /home/matrix/matrix-ircd \
 && cargo build

USER root

WORKDIR /home/matrix/matrix-ircd

EXPOSE 5999

CMD gosu matrix cargo run -- --url https://matrix.xsteadfastx.org --bind 0.0.0.0:5999
