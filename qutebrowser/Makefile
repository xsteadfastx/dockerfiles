.PHONY: build run

UID := 1000

build:
	docker build -t qutebrowser .

run:
	xhost +local:
	docker run --rm -ti -e USER_ID=$(UID) -e DISPLAY=$(DISPLAY) -e XAUTHORITY=$(HOME)/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/$(UID)/pulse:/run/pulse -v $(HOME)/.config/pulse/cookie:/tmp/pulse_cookie qutebrowser
