# Configuration

APP := montreal-elixir-production
BINARY := montreal_elixir_platform

# Targets

.PHONY: deploy
deploy: push release

push:
	heroku container:login
	heroku container:push web -r production

release:
	heroku container:release web -r production

bash:
	heroku run bash -r production
