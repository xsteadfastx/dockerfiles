PHONY.: build run test

HOSTUSER=$(USER)
USERID=$(shell id -u)
GROUPID=$(shell id -g)

build:
	docker build -t rip_show .

run:
	docker run --rm -ti -e HOSTUSER=$(HOSTUSER) -e USERID=$(USERID) -e GROUPID=$(GROUPID) --device /dev/dvd:/dev/dvd -v $(HOME):/data rip_show
