FROM alpine:3.2

ADD https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 /usr/sbin/gosu
RUN echo "@edge http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --update \
    s6@edge \
    python \
    ansible@edge \
    git \
    nginx \
    php-fpm \
    php-json php-curl php-gd php-mysql php-mcrypt php-cgi php-apcu php-dom php-pcntl@edge php-posix \
    py-simplejson py-mysqldb@edge \
    mariadb-client \
    && rm -rf /var/cache/apk/* \
    && chmod +x /usr/sbin/gosu

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN git clone --depth 1 https://tt-rss.org/git/tt-rss.git /var/www/ttrss

RUN chown -Rv nobody:nobody /var/www/ttrss \
    && chown -Rv nobody:nobody /var/lib/nginx

COPY root /
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ttrss"]
