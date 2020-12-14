# Configuration

WEB_APP := montreal_elixir_web
DOCKER_COMPOSE := docker-compose

# Targets

build: docker.stop docker.port.review docker.down docker.build docker.start app.setup
start: docker.start
stop: docker.stop

app.setup:
	$(DOCKER_COMPOSE) exec application mix deps.get
	$(DOCKER_COMPOSE) exec application sh -c 'cd /app/apps/$(WEB_APP)/assets/ && npm install'
	# Setup test DB
	$(DOCKER_COMPOSE) exec -e MIX_ENV=test application mix ecto.create
	$(DOCKER_COMPOSE) exec -e MIX_ENV=test application mix ecto.migrate
	# Setup dev DB
	$(DOCKER_COMPOSE) exec application mix ecto.create
	$(DOCKER_COMPOSE) exec application mix ecto.migrate

app.observe:
	open -a xquartz
	$(DOCKER_COMPOSE) exec -e DISPLAY=host.docker.internal:0 erlang erl -sname observer -hidden -setcookie secret -run observer

app.config:
	cp config/dev.secret.exs.sample config/dev.secret.exs
	cp config/test.secret.exs.sample config/test.secret.exs
	cp env.sample .env

	echo "Please configure the 'secret' configuration files in ./config directory."

app.console:
	$(DOCKER_COMPOSE) exec application iex --name vm@application --cookie secret -S mix phx.server

app.run:
	$(DOCKER_COMPOSE) exec application mix phx.server

app.test:
	$(DOCKER_COMPOSE) exec application mix test

app.do:
	$(DOCKER_COMPOSE) exec application $(CMD)

docker.build:
	$(DOCKER_COMPOSE) build --force-rm --no-cache

docker.reset: docker.stop docker.clean docker.start app.setup

docker.down:
	$(DOCKER_COMPOSE) down --volumes

docker.clean:
	$(DOCKER_COMPOSE) rm -v -f
	 down --volumes
	docker-sync clean -c ops/dev/docker-sync.yml

docker.start:
	docker-sync start -c ops/dev/docker-sync.yml
	$(DOCKER_COMPOSE) up --detach

docker.stop:
	$(DOCKER_COMPOSE) stop
	docker-sync stop -c ops/dev/docker-sync.yml

docker.restart: stop start

docker.port.review:
	echo "Please ensure no Docker containers are running with the same ports as this docker-compose.yml file:"
	docker ps
	read -p "Press any key to continue..."

docker.bash:
	$(DOCKER_COMPOSE) application bash
