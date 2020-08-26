.PHONY: help mopidy traefik irc taskd all

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

traefik: ## Get traefik services up
	@docker network inspect nginx_backend >/dev/null 2>&1 || docker network create nginx_backend
	cd /opt/dockerfiles/jellyfin && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/gitea && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/nextcloud && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/navidrome && docker-compose up --force-recreate -d
	cd /opt/dockerfiles/traefik && docker-compose up --force-recreate -d

irc: ## Get communication services up
	@docker network inspect communication_backend >/dev/null 2>&1 || docker network create communication_backend
	cd /opt/dockerfiles/bitlbee && docker-compose up --force-recreate -d

taskd: ## Get taskwarrior services up
	cd /opt/dockerfiles/taskd && docker-compose up --force-recreate -d

mopidy: ## Get mopidy services up
	cd /opt/dockerfiles/mopidy && docker-compose up --force-recreate -d

dnsmasq: ## Getting dnsmasq up
	cd /opt/dockerfiles/dnsmasq && docker-compose up --force-recreate -d

all: traefik irc
