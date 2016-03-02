#!/bin/sh

letsencrypt certonly --email $EMAIL --agree-tos --duplicate --webroot -w $WEBROOTPATH $@
cat /var/log/letsencrypt/letsencrypt.log
