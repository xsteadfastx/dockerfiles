#!/bin/sh
set -e

groupadd --gid "$GROUP_ID" tox
useradd --gid "$GROUP_ID" --uid "$USER_ID" --create-home --home-dir /home/tox tox

gosu tox:tox "$@"
