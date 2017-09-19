#!/bin/sh

set -ex

adduser -h /home/marv -H -u "$USER_ID" -s /bin/sh -D marv

echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk upgrade --available
apk add \
    alpine-sdk \
    git-email \
    openssh-client

addgroup marv abuild

mkdir -p /var/cache/distfiles
chmod a+w /var/cache/distfiles

echo "marv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

su marv -c "
        git config --global user.name Marvin\ Steadfast && \
        git config --global user.email marvin@xsteadfastx.org && \
        git config --global sendemail.smtpserver smtp.gmail.com && \
        git config --global sendemail.smtpserverport 587 && \
        git config --global sendemail.smtpencryption tls && \
        git config --global sendemail.smtpuser xsteadfastx@gmail.com
"

rm -rf /home/marv/packages

exec su marv -c /bin/sh
