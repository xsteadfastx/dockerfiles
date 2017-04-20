.PHONY: build run

build:
	docker build -t xsteadfastx/alpine-devel .

run:
	docker run --rm -ti -v /opt/alpine-devel:/home/marv -v /home/$(USER)/.ssh:/home/marv/.ssh -e "USER_ID=1000" xsteadfastx/alpine-devel
