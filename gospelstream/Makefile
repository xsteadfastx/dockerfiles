UID := 1000

.PHONY: build run play down

build:
	docker-compose build
	docker build -t gospelplayer player/

run:
	docker-compose up --force-recreate

play:
ifndef STREAM
	$(error STREAM is undefined)
endif
	docker run --rm -ti -v /run/user/$(UID)/pulse:/run/pulse -v $(HOME)/.config/pulse/cookie:/tmp/pulse_cookie -e "STREAM=$(STREAM)" gospelplayer gospelplayer

down:
	docker-compose down -v --remove-orphans
