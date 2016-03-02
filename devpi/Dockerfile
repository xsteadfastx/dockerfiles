FROM alpine:3.2

ADD https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 /usr/sbin/gosu
ADD https://bootstrap.pypa.io/get-pip.py get-pip.py
RUN apk add --update \
    python3 \
 && rm -rf /var/cache/apk/* \
 && python3 get-pip.py \
 && pip install devpi \
 && chmod +x /usr/sbin/gosu

RUN adduser -S -H devpi

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/data"]
EXPOSE 3141
ENTRYPOINT ["/entrypoint.sh"]
CMD ["devpi-server"]
