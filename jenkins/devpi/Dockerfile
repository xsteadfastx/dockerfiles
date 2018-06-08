FROM python:3.4.3-slim

LABEL name=devpi \
      version="0.0.0"

RUN pip install devpi-server

RUN mkdir /srv/devpi
VOLUME ["/srv/devpi"]

EXPOSE 3141
CMD devpi-server --host 0.0.0.0 --serverdir /srv/devpi
