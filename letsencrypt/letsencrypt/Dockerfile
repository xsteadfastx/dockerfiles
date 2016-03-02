FROM alpine:3.2

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

# install deps
RUN apk add --update \
    git \
    gcc \
    musl-dev \
    linux-headers \
    openssl-dev \
    libffi-dev \
    python \
    python-dev \
    dialog \
 && rm -rf /var/cache/apk/* \
 && python /tmp/get-pip.py \
 && rm -rf /tmp/get-pip.py \
 && git clone --depth 1 https://github.com/letsencrypt/letsencrypt /tmp/letsencrypt \
 && pip install /tmp/letsencrypt/acme \
 && pip install /tmp/letsencrypt \
 && rm -rf /tmp/letsencrypt \
 && apk del \
    git \
    gcc \
    musl-dev \
    linux-headers \
    openssl-dev \
    libffi-dev \
    python-dev

COPY root /
RUN chmod +x /entrypoint.sh

VOLUME ["/etc/letsencrypt", "/var/lib/letsencrypt"]
ENTRYPOINT ["/entrypoint.sh"]
