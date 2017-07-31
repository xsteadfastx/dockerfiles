PHONY.: build run

USERID=$(shell id -u)
GROUPID=$(shell id -g)

build:
	docker build -t vuescan .

run:
	xhost +local:
	touch /home/$(USER)/.vuescanrc
	docker run --rm -ti --privileged -e USERID=$(USERID) -e GROUPID=$(GROUPID) -e DISPLAY=$(DISPLAY) -e XAUTHORITY=$(HOME)/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$(USER)/Nextcloud/Scan:/root/Scan -v /home/$(USER)/.vuescan:/root/.vuescan -v /home/$(USER)/.vuescanrc:/root/.vuescanrc -v /dev/bus/usb:/dev/bus/usb vuescan
