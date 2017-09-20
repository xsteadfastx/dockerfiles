.PHONY: build run

build:
	docker build -t icecast .

run:
	docker run --rm -ti -p 8000:8000 icecast:latest
