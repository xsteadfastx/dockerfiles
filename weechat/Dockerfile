FROM alpine:edge

LABEL name=weechat \
      version="0.0.0"

ENV USER_ID 1000
ENV GROUP_ID 1000
ENV LANG C.UTF-8
ENV TERM screen-256color

RUN set -ex \
 && apk add -U --no-cache busybox \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        gcc \
        lua \
        lua-cjson \
        musl-dev \
        openssh-client \
        py-pip \
        python \
        python-dev \
        su-exec \
        weechat \
        weechat-lua \
        weechat-perl \
        weechat-python \
        weechat-ruby \
 && pip install python-potr \
 && addgroup -g $GROUP_ID weechat \
 && adduser -u $USER_ID -G weechat -D weechat

EXPOSE 8002

CMD ["su-exec", "weechat", "weechat"]
