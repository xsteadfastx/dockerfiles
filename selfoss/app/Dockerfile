FROM alpine:edge

ARG VERSION=2.17

RUN set -ex \
 && apk upgrade -a --no-cache \
 && apk add --no-cache --virtual .fetch-deps \
        curl \
 && apk add --no-cache \
        ansible \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-session \
        php7-simplexml \
        php7-xml \
        php7-xmlwriter \
        php7-zlib \
        py-mysqldb \
 && { \
        echo '[global]'; \
        echo 'error_log = /proc/self/fd/2'; \
        echo; \
        echo '[www]'; \
        echo '; if we send this to /proc/self/fd/1, it never appears'; \
        echo 'access.log = /proc/self/fd/2'; \
        echo; \
        echo 'clear_env = no'; \
        echo; \
        echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
        echo 'catch_workers_output = yes'; \
    } > /etc/php7/php-fpm.d/docker.conf \
 && { \
        echo '[global]'; \
        echo 'daemonize = no'; \
        echo; \
        echo '[www]'; \
        echo 'listen = [::]:9000'; \
    } > /etc/php7/php-fpm.d/zz-docker.conf \
 && mkdir -p /var/www/selfoss \
 && curl -L -o /var/www/selfoss/selfoss.zip https://github.com/SSilence/selfoss/releases/download/$VERSION/selfoss-$VERSION.zip \
 && unzip /var/www/selfoss/selfoss.zip -d /var/www/selfoss \
 && rm /var/www/selfoss/selfoss.zip \
 && apk del .fetch-deps

ADD root /

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["selfoss"]
