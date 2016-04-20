FROM alpine:3.3
MAINTAINER Marvin Steadfast <marvin@xsteadfastx.org>

# Install necessary stuff
RUN apk add --update \
      su-exec \
      taskd \
      taskd-pki \
 && rm -rf /var/cache/apk/*

# Add user
RUN adduser -h /var/taskd -H -s /sbin/nologin -D taskd

# Import build and startup script
COPY root /

# Set the data location
ENV TASKDDATA /var/taskd

# Configure container
VOLUME ["/var/taskd"]

EXPOSE 53589

ENTRYPOINT ["/entrypoint.sh"]
CMD ["taskd"]
