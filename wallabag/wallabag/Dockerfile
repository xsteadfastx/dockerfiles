FROM alpine:edge
ENV WALLABAG_VERSION 2.0.0

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
      ansible \
      curl \
      libwebp@testing \
      nginx \
      pcre \
      php7-ctype@testing \
      php7-curl@testing \
      php7-dom@testing \
      php7-fpm@testing \
      php7-gd@testing \
      php7-gettext@testing \
      php7-json@testing \
      php7-mbstring@testing \
      php7-pdo_mysql@testing \
      php7-session@testing \
      php7-xml@testing \
      php7@testing\
      py-simplejson \
      py-mysqldb \
      mariadb-client \
      s6 \
 && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

ADD https://github.com/wallabag/wallabag/releases/download/$WALLABAG_VERSION/wallabag-release-$WALLABAG_VERSION.tar.gz /tmp/

RUN tar xvfz /tmp/wallabag-release-$WALLABAG_VERSION.tar.gz -C /var/www/ \
 && mv /var/www/release-$WALLABAG_VERSION /var/www/wallabag \
 && rm /tmp/wallabag-release-$WALLABAG_VERSION.tar.gz

COPY root /

RUN chown -Rv nobody:nobody /var/www/wallabag

RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["wallabag"]
