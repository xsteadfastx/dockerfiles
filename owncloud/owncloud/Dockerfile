FROM alpine:3.2
ENV owncloud_version 8.2.2

RUN echo "@edge http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
    s6@edge \
    nginx \
    php-fpm \
    php-gd \
    php-json \
    php-mysql \
    php-curl \
    php-intl \
    php-mcrypt \
    php-imagick@testing \
    php-sqlite3 \
    php-apcu \
    php-pdo \
    php-pdo_sqlite \
    php-zip \
    php-dom \
    php-xml \
    php-ctype \
    php-zlib \
    php-iconv \
 && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

ADD https://download.owncloud.org/community/owncloud-${owncloud_version}.tar.bz2 /var/www/
RUN tar xvfj /var/www/owncloud-${owncloud_version}.tar.bz2 -C /var/www/
RUN chown -Rv nobody:nobody /var/www/owncloud

COPY root /
RUN rm -rf /var/lib/nginx \
 && mkdir /var/lib/nginx \
 && mkdir /var/lib/nginx/tmp \
 && chown -Rv nobody:nobody /var/lib/nginx
RUN chmod +x /entrypoint.sh

VOLUME ["/var/www/owncloud/data", "/var/www/owncloud/config"]
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["owncloud"]
