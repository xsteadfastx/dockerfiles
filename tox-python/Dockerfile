FROM ubuntu:trusty

ENV LANG C.UTF-8

RUN groupadd tox \
 && useradd -u 1000 -g 1000 tox \
 && gpg --keyserver keyserver.ubuntu.com --recv-keys DB82666C \
 && gpg --export DB82666C | apt-key add - \
 && echo deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list \
 && echo deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y \
        python3-pip \
        python2.3 \
        python2.4 \
        python2.5 \
        python2.6 \
        python2.7 \
        python3.1 \
        python3.2 \
        python3.3 \
        python3.4 \
        python3.5 \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install tox
