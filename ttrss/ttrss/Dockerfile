FROM alpine:edge

ADD https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 /usr/sbin/gosu

RUN apk add --update \
    s6 \
    ansible \
    git \
    nginx \
    php5-fpm \
    php5-json \
    php5-curl \
    php5-gd \
    php5-mysql \
    php5-mcrypt \
    php5-cgi \
    php5-apcu \
    php5-dom \
    php5-pcntl \
    php5-posix \
    py-simplejson \
    py-mysqldb \
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
