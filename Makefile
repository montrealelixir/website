# Configuration

WEB_APP := montreal_elixir_web

# Targets

build: docker.stop docker.port.review docker.down docker.build docker.start app.setup
start: docker.start
stop: docker.stop

app.setup:
	docker-compose exec application mix deps.get
	docker-compose exec application sh -c 'cd /app/apps/$(WEB_APP)/assets/ && npm install'
	# Setup test DB
	docker-compose exec -e MIX_ENV=test application mix ecto.create
	docker-compose exec -e MIX_ENV=test application mix ecto.migrate
	# Setup dev DB
	docker-compose exec application mix ecto.create
	docker-compose exec application mix ecto.migrate

app.observe:
	open -a xquartz
	docker-compose exec -e DISPLAY=host.docker.internal:0 erlang erl -sname observer -hidden -setcookie secret -run observer

app.config:
	cp config/dev.secret.exs.sample config/dev.secret.exs
	cp config/test.secret.exs.sample config/test.secret.exs
	cp env.sample .env

	echo "Please configure the 'secret' configuration files in ./config directory."
	echo "If developing on MacOS, update ./env file."

app.console:
	docker-compose exec application iex --name vm@application --cookie secret -S mix phx.server

app.run:
	docker-compose exec application mix phx.server

app.test:
	docker-compose exec application mix test

app.do:
	docker-compose exec application $(CMD)

docker.build:
	docker-compose build --force-rm --no-cache

docker.reset: docker.stop docker.clean docker.start app.setup

docker.down:
	docker-compose down --volumes

docker.clean:
	docker-compose rm -v -f
	docker-compose down --volumes
	(which docker-sync && docker-sync clean -c ops/dev/docker-sync.yml) || exit 0

docker.start:
	(which docker-sync && docker-sync start -c ops/dev/docker-sync.yml) || exit 0
	docker-compose up --detach

docker.stop:
	docker-compose stop
	(which docker-sync && docker-sync stop -c ops/dev/docker-sync.yml) || exit 0

docker.restart: stop start

docker.port.review:
	echo "Please ensure no Docker containers are running with the same ports as this docker-compose.yml file:"
	docker ps
	read -p "Press any key to continue..."

docker.bash:
	docker-compose application bash
