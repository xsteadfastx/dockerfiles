FROM jenkins

LABEL name=jenkins \
      version="0.0.0"

# docker group id of the host docker group
ENV DOCKER_GID 132

USER root

RUN apt-get update && \
    apt-get install -y \
    curl \
    python-dev \
    python-setuptools \
    python-virtualenv \
    python-pip \
    libjpeg-dev \
    ansible \
    mysql-client \
    sudo && \
    rm -rf /var/lib/apt/lists/* && \
    pip install tox

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN groupadd -g $DOCKER_GID docker && usermod -a -G docker jenkins

USER jenkins
