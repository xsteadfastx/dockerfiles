.PHONY: help mopidy nginx irc taskd all

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

nginx: ## Get nginx services up
	cd /opt/dockerfiles/emby && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/gitea && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/nextcloud && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/wallabag && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/synapse && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/mastodon && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/selfoss && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/nginx && docker-compose up --force-recreate -d

irc: ## Get communication services up
	cd /opt/dockerfiles/prosody && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/bitlbee && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/synapse && docker-compose up --force-recreate -d

taskd: ## Get taskwarrior services up
	cd /opt/dockerfiles/taskd && docker-compose up --force-recreate -d

mopidy: ## Get mopidy services up
	cd /opt/dockerfiles/mopidy && docker-compose up --force-recreate -d

all: nginx irc mopidy
