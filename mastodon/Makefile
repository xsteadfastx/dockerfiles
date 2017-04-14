.PHONY: clean migrate assets

clean:
	docker-compose run --rm web rake mastodon:media:clear
	docker-compose run --rm web rake mastodon:push:refresh
	docker-compose run --rm web rake mastodon:push:clear
	docker-compose run --rm web rake mastodon:feeds:clear

migrate:
	docker-compose run --rm web rails db:migrate

assets:
	docker-compose run --rm web rails assets:precompile
