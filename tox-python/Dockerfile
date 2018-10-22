FROM ubuntu:xenial

LABEL Name="tox-python"
LABEL Version="0.3.0"

ARG USER_ID=1000
ARG GROUP_ID=1000

ENV LANG C.UTF-8
ENV HOME /home/tox
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

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
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /tini \
 && groupadd --gid "$GROUP_ID" tox \
 && useradd --gid "$GROUP_ID" --uid "$USER_ID" --create-home --home-dir /home/tox tox

USER tox

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
    py35=3.5.6 \
    py36=3.6.7 \
    py37=3.7.1 \
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

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
