# Configuration

APP := montreal-elixir-staging
BINARY := montreal_elixir_platform

# Targets

.PHONY: deploy
deploy: push release reset

push:
	git fetch --all --tags
	heroku container:login
	heroku container:push web -r staging

release:
	heroku container:release web -r staging

reset:
	heroku pg:reset --confirm $(APP) -r staging

bash:
	heroku run bash -r staging
