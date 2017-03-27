FROM debian:jessie

ENV LANG C.UTF-8

RUN set -ex \
 && apt-get update \
 && apt-get install -y \
        bash \
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
        zlib1g-dev \
 && git clone https://github.com/yyuu/pyenv.git ~/.pyenv \
 && echo 'export PYENV_ROOT="~/.pyenv"' >> ~/.bashrc \
 && echo 'export PATH="~/.pyenv/bin:$PATH"' >> ~/.bashrc \
 &&  ~/.pyenv/bin/pyenv install 2.1.3 \
 &&  ~/.pyenv/bin/pyenv install 2.2.3 \
 &&  ~/.pyenv/bin/pyenv install 2.3.7 \
 &&  ~/.pyenv/bin/pyenv install 2.4.6 \
 &&  ~/.pyenv/bin/pyenv install 2.5.6 \
 &&  ~/.pyenv/bin/pyenv install 2.6.9 \
 &&  ~/.pyenv/bin/pyenv install 2.7.9 \
 &&  ~/.pyenv/bin/pyenv install 3.3.6 \
 &&  ~/.pyenv/bin/pyenv install 3.4.6 \
 &&  ~/.pyenv/bin/pyenv install 3.5.3 \
 &&  ~/.pyenv/bin/pyenv install 3.6.1 \
 &&  ~/.pyenv/bin/pyenv global 3.6.1 3.5.3 3.4.6 3.3.6 2.7.9 2.6.9 2.5.6 2.4.6 2.3.7 2.2.3 2.1.3 \
 &&  ~/.pyenv/shims/pip3.6 install tox \
 && echo 'eval "$(pyenv init -)"' >> ~/.bashrc \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
