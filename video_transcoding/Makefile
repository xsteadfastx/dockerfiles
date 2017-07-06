PHONY.: build run test

USERID=$(shell id -u)
GROUPID=$(shell id -g)

build:
	docker build -t video_transcoding .

run:
	docker run --rm -ti -e USERID=$(USERID) -e GROUPID=$(GROUPID) --device /dev/dvd:/dev/dvd -v $(HOME):/data video_transcoding
