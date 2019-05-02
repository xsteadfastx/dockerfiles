FROM ubuntu:xenial as base
ENV PY_VERSIONS="3.8-dev 3.7.3 3.6.8 3.5.6 3.4.8 3.3.7 3.2.6 3.1.5 3.0.1 2.7.15 2.6.9 2.5.6 2.4.6 pypy3.6-7.1.1 pypy2.7-7.1.1"
ENV USER_ID=1000
ENV GROUP_ID=1000
ENV LANG C.UTF-8
ENV HOME /home/tox
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN set -ex \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
        sudo \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd --gid "$GROUP_ID" tox \
 && useradd --gid "$GROUP_ID" --uid "$USER_ID" --create-home --home-dir /home/tox tox \
 && echo 'tox ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/tox \
 && chmod 0440 /etc/sudoers.d/tox

FROM base as builder
USER tox
RUN set -ex \
 && sudo apt-get update \
 && sudo apt-get install -y \
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
        zlib1g-dev \
 && git clone https://github.com/yyuu/pyenv.git ~/.pyenv \
 && for i in $PY_VERSIONS; do ~/.pyenv/bin/pyenv install $i; done \
 && ~/.pyenv/bin/pyenv global $PY_VERSIONS \
 && ~/.pyenv/bin/pyenv rehash \
 && ~/.pyenv/shims/python3.7 -m pip install tox \
 && ~/.pyenv/shims/python3.7 -m pip install poetry \
 && ~/.pyenv/bin/pyenv rehash

FROM base
COPY --chown=tox:tox --from=builder /home/tox/.pyenv /home/tox/.pyenv
RUN set -ex \
 && apt-get update \
 && apt-get install -y \
        bash \
        expat \
        git \
        bzip2 \
        libffi6 \
        libsqlite3-0 \
        libssl1.0.0 \
 && rm -rf /var/lib/apt/lists/*
USER tox
