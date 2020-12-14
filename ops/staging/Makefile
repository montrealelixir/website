# Configuration

APP := montreal-elixir-staging
BINARY := montreal_elixir_platform
HEROKU_APP := montreal-elixir-staging
ERLANG_COOKIE := $(shell heroku config:get ERLANG_COOKIE -a $(HEROKU_APP))

# Targets

.PHONY: deploy
deploy: push release reset

push:
	heroku container:login
	heroku container:push web -r staging

release:
	heroku container:release web -r staging

reset:
	heroku pg:reset --confirm $(APP) -r staging

heroku.bash:
	heroku ps:exec -a $(HEROKU_APP)

heroku.port.forward:
	heroku ps:forward 4369,9001 -a $(HEROKU_APP)

heroku.observe:
	epmd -names
	iex --name console@127.0.0.1 --cookie '$(ERLANG_COOKIE)' -e ':observer.start'
