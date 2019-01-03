FROM alpine:edge as base

LABEL name=weechat \
      version="0.0.0"

ENV USER_ID 1000
ENV GROUP_ID 1000
ENV LANG C.UTF-8
ENV TERM screen-256color

RUN set -ex \
 && apk add -U --no-cache busybox \
 && apk upgrade -a --no-cache

FROM base as builder

RUN set -ex \
 && apk add --no-cache \
        gcc \
        musl-dev \
        py-pip \
        python-dev \
 && mkdir /install \
 && pip install --install-option="--prefix=/install" \
        python-potr

FROM base

COPY --from=builder /install /usr/local

ENV PYTHONPATH /usr/local/lib/python2.7/site-packages

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        lua \
        lua-cjson\
        python \
        su-exec \
        openssh-client \
        weechat \
        weechat-lua \
        weechat-perl \
        weechat-python \
        weechat-ruby \
 && addgroup -g $GROUP_ID weechat \
 && adduser -u $USER_ID -G weechat -D weechat

EXPOSE 8002

CMD ["su-exec", "weechat", "weechat"]
