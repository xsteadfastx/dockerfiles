UID := 1000

.PHONY: build run

build:
	docker build -t snapclient .

run:
ifndef SNAPSERVER
	$(error SNAPSERVER is undefined)
endif
	docker run --rm -ti -v /run/user/$(UID)/pulse:/run/pulse -v $(HOME)/.config/pulse/cookie:/tmp/pulse_cookie -e "SNAPSERVER=$(SNAPSERVER)" snapclient snapclient
