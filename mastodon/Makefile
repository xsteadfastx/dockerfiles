.PHONY: clean daily prepare-migrate migrate assets confirm clear-cache

clean:
	docker-compose run --rm web rake mastodon:media:clear
	docker-compose run --rm web rake mastodon:push:refresh
	docker-compose run --rm web rake mastodon:push:clear
	docker-compose run --rm web rake mastodon:feeds:clear
	docker-compose run --rm web rake mastodon:users:clear

daily:
	docker-compose run --rm web rake mastodon:daily

prepare-migrate:
	docker-compose run --rm web rails mastodon:maintenance:prepare_for_foreign_keys

migrate:
	docker-compose run --rm web rails db:migrate

assets:
	docker-compose run --rm web rails assets:precompile

confirm:
	docker-compose run --rm web rails mastodon:confirm_email USER_EMAIL=$(USER_EMAIL)

clear-cache:
	docker-compose run --rm web rails r Rails.cache.clear
