FROM alpine:edge

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN set -ex \
 && apk add -U --no-cache busybox \
 && apk upgrade -a --no-cache \
 && apk add --no-cache \
        lua \
        lua-cjson \
        python \
        su-exec \
        weechat \
        weechat-lua \
        weechat-perl \
        weechat-python \
        weechat-ruby \
 && addgroup -g $GROUP_ID weechat \
 && adduser -u $USER_ID -G weechat -D weechat

EXPOSE 8002

CMD ["su-exec", "weechat", "weechat"]