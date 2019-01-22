#!/bin/sh
set -e
chown -R tox:tox "$PWD"
exec /gosu tox:tox "$@"
