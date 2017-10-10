FROM debian:jessie-slim

ENV py21=2.1.3 \
    py22=2.2.3 \
    py23=2.3.7 \
    py24=2.4.6 \
    py25=2.5.6 \
    py26=2.6.9 \
    py27=2.7.14 \
    py33=3.3.6 \
    py34=3.4.7 \
    py35=3.5.4 \
    py36=3.6.3

ENV LANG C.UTF-8
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN set -ex \
 && buildDeps='\
        build-essential \
        curl \
        git \
        libbz2-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        llvm \
        make \
        wget \
        xz-utils \
        zlib1g-dev' \
 && apt-get update \
 && apt-get install -y $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/yyuu/pyenv.git ~/.pyenv \
 &&  ~/.pyenv/bin/pyenv install $py21 \
 &&  ~/.pyenv/bin/pyenv install $py22 \
 &&  ~/.pyenv/bin/pyenv install $py23 \
 &&  ~/.pyenv/bin/pyenv install $py24 \
 &&  ~/.pyenv/bin/pyenv install $py25 \
 &&  ~/.pyenv/bin/pyenv install $py26 \
 &&  ~/.pyenv/bin/pyenv install $py27 \
 &&  ~/.pyenv/bin/pyenv install $py33 \
 &&  ~/.pyenv/bin/pyenv install $py34 \
 &&  ~/.pyenv/bin/pyenv install $py35 \
 &&  ~/.pyenv/bin/pyenv install $py36 \
 &&  ~/.pyenv/bin/pyenv global $py36 $py35 $py34 $py33 $py33 $py27 $py26 $py25 $py24 $py23 $py22 $py21 \
 &&  ~/.pyenv/shims/pip3.6 install tox \
 && ~/.pyenv/bin/pyenv rehash \
 && apt-get purge -y --auto-remove $buildDeps
