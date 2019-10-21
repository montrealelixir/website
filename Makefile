# Configuration

WEB_APP := montreal_elixir_web

# Targets

build: docker.stop docker.port.review docker.down docker.build docker.start app.setup
start: docker.start
stop: docker.stop

app.setup:
	docker-compose exec application mix deps.get
	docker-compose exec application sh -c 'cd /app/apps/$(WEB_APP)/assets/ && npm install'
	# TEST
	docker-compose exec -e MIX_ENV=test application mix ecto.create
	docker-compose exec -e MIX_ENV=test application mix event_store.init
	docker-compose exec -e MIX_ENV=test application mix ecto.migrate
	# DEV
	docker-compose exec application mix ecto.create
	docker-compose exec application mix event_store.init
	docker-compose exec application mix ecto.migrate
	docker-compose exec application mix project.setup

app.docs:
	docker-compose exec application mix docs
	docker-compose exec application cp GLOSSARY.md apps/$(WEB_APP)/priv/static/
	docker-compose exec application cp -R doc apps/$(WEB_APP)/priv/static/

app.observe:
	open -a xquartz
	docker-compose exec -e DISPLAY=host.docker.internal:0 erlang erl -sname observer -hidden -setcookie secret -run observer

app.config:
	cp config/dev.secret.exs.sample config/dev.secret.exs
	cp config/test.secret.exs.sample config/test.secret.exs
	cp env.sample .env

	echo "Please configure the 'secret' configuration files in ./config directory."

app.console:
	docker-compose exec application iex --name vm@application --cookie secret -S mix phx.server

app.run:
	docker-compose exec application mix phx.server

app.test:
	docker-compose exec application mix test

docker.build:
	docker-compose build --force-rm --no-cache

docker.reset: docker.stop docker.clean docker.start app.setup

docker.down:
	docker-compose down --volumes

docker.clean:
	docker-compose rm -v -f
	docker-compose down --volumes
	docker-sync clean

docker.start:
	docker-sync start
	docker-compose up --detach

docker.stop:
	docker-compose stop
	docker-sync stop

docker.restart: stop start

docker.port.review:
	echo "Please ensure no Docker containers are running with the same ports as this docker-compose.yml file:"
	docker ps
	read -p "Press any key to continue..."

docker.bash:
	docker-compose exec application bash
