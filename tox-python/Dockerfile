FROM ubuntu:trusty

ENV LANG C.UTF-8

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys DB82666C \
 && gpg --export DB82666C | apt-key add - \
 && echo deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list \
 && echo deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y \
        curl \
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
        sudo \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd -g 1000 tox \
 && useradd -u 1000 -g 1000 -G sudo tox \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
 && curl https://bootstrap.pypa.io/get-pip.py | python3.5 \
 && pip install tox
