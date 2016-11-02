.PHONY: help nginx irc taskd all

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

nginx: ## Get nginx services up
	cd /opt/dockerfiles/emby && docker-compose up -d
	cd /opt/dockerfiles/gogs && docker-compose up -d
	cd /opt/dockerfiles/nextcloud && docker-compose up -d
	cd /opt/dockerfiles/ttrss && docker-compose up -d
	cd /opt/dockerfiles/wallabag && docker-compose up -d
	cd /opt/dockerfiles/paperless && docker-compose up -d
	cd /opt/dockerfiles/nginx && docker-compose up -d

irc: ## Get communication services up
	cd /opt/dockerfiles/prosody && docker-compose up -d
	cd /opt/dockerfiles/bitlbee && docker-compose up -d

taskd: ## Get taskwarrior services up
	cd /opt/dockerfiles/taskd && docker-compose up -d

all: nginx irc taskd
