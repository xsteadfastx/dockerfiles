FROM ubuntu:xenial

LABEL Name="tox-python"
LABEL Version="0.2.0"

ENV USER_ID 1000
ENV GROUP_ID 1000

ENV LANG C.UTF-8
ENV HOME /opt
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

ENV GOSU_VERSION 1.10

RUN set -ex \
 && buildDeps='\
        build-essential \
        ca-certificates \
        curl \
        git \
        libbz2-dev \
        libncurses5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        llvm \
        make \
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev' \
 && apt-get update \
 && apt-get install -y $buildDeps \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && chmod +x /usr/local/bin/gosu \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /tini

ENV py21=2.1.3 \
    py22=2.2.3 \
    py23=2.3.7 \
    py24=2.4.6 \
    py25=2.5.6 \
    py26=2.6.9 \
    py27=2.7.15 \
    py30=3.0.1 \
    py31=3.1.5 \
    py32=3.2.6 \
    py33=3.3.7 \
    py34=3.4.8 \
    py35=3.5.5 \
    py36=3.6.6 \
    py37=3.7.0 \
    pypy27=pypy2.7-6.0.0 \
    pypy35=pypy3.5-6.0.0

 RUN set -ex \
 && git clone https://github.com/yyuu/pyenv.git ~/.pyenv \
 &&  ~/.pyenv/bin/pyenv install $py21 \
 &&  ~/.pyenv/bin/pyenv install $py22 \
 &&  ~/.pyenv/bin/pyenv install $py23 \
 &&  ~/.pyenv/bin/pyenv install $py24 \
 &&  ~/.pyenv/bin/pyenv install $py25 \
 &&  ~/.pyenv/bin/pyenv install $py26 \
 &&  ~/.pyenv/bin/pyenv install $py27 \
 &&  ~/.pyenv/bin/pyenv install $py30 \
 &&  ~/.pyenv/bin/pyenv install $py31 \
 &&  ~/.pyenv/bin/pyenv install $py32 \
 &&  ~/.pyenv/bin/pyenv install $py33 \
 &&  ~/.pyenv/bin/pyenv install $py34 \
 &&  ~/.pyenv/bin/pyenv install $py35 \
 &&  ~/.pyenv/bin/pyenv install $py36 \
 &&  ~/.pyenv/bin/pyenv install $py37 \
 &&  ~/.pyenv/bin/pyenv install $pypy27 \
 &&  ~/.pyenv/bin/pyenv install $pypy35 \
 &&  ~/.pyenv/bin/pyenv global \
        $py37 \
        $py36 \
        $py35 \
        $py34 \
        $py33 \
        $py32 \
        $py31 \
        $py30 \
        $py27 \
        $py26 \
        $py25 \
        $py24 \
        $py23 \
        $py22 \
        $py21 \
        $pypy27 \
        $pypy35 \
 &&  ~/.pyenv/shims/pip3.7 install tox \
 && ~/.pyenv/bin/pyenv rehash

USER root

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
CMD ["/bin/bash"]
