FROM alpine:3.3

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
    perl \
    prosody@testing \
 && rm -rf /var/cache/apk/*

# Configure prosody
RUN sed -i '1s/^/daemonize = false;\n/' /etc/prosody/prosody.cfg.lua \
    && perl -i -pe 'BEGIN{undef $/;} s/^log = {.*?^}$/log = {\n    {levels = {min = "info"}, to = "console"};\n}/smg' /etc/prosody/prosody.cfg.lua

EXPOSE 80 443 5222 5269 5347 5280 5281
VOLUME ["/etc/prosody", "/var/lib/prosody", "/var/log/prosody", "/usr/lib/prosody-modules"]
CMD ["prosodyctl", "start"]
