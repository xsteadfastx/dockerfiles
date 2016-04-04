FROM alpine:edge
ENV wallabag_version 2.0.0-beta.2

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
      curl \
      git \
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
      php7-openssl@testing \
      php7-pdo_sqlite@testing \
      php7-phar@testing \
      php7-session@testing \
      php7-xml@testing \
      php7@testing\
      s6 \
 && ln -s /usr/bin/php7 /usr/bin/php \
 && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

RUN curl -s http://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

RUN git clone https://github.com/wallabag/wallabag.git /var/www/wallabag \
 && cd /var/www/wallabag \
 && git checkout 2.0.0

COPY root /

RUN cd /var/www/wallabag \
 && SYMFONY_ENV=prod composer install --no-dev -o --prefer-dist \
 && php bin/console wallabag:install --env=prod

RUN chown -Rv nobody:nobody /var/www/wallabag

RUN rm -rf /var/lib/nginx \
 && mkdir /var/lib/nginx \
 && mkdir /var/lib/nginx/tmp \
 && chown -Rv nobody:nobody /var/lib/nginx

RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["wallabag"]
