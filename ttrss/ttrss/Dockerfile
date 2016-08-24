FROM alpine:edge

RUN apk add --update \
    ansible \
    git \
    mariadb-client \
    nginx \
    php5-apcu \
    php5-cgi \
    php5-curl \
    php5-dom \
    php5-fpm \
    php5-gd \
    php5-json \
    php5-mcrypt \
    php5-mysql \
    php5-mysqli \
    php5-pcntl \
    php5-pdo_mysql \
    php5-posix \
    py-mysqldb \
    py-simplejson \
    s6 \
    su-exec \
 && rm -rf /var/cache/apk/*

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
