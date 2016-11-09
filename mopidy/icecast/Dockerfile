FROM alpine:3.4

RUN apk add --no-cache \
        icecast \
        su-exec

COPY root /

EXPOSE 8000

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["icecast"]
