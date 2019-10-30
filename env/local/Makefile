# Configuration - Local

IMAGE_NAME := montreal-elixir-local
BINARY := montreal_elixir_platform

# Configuration - Heroku

DATABASE_URL := $(shell heroku config:get DATABASE_URL -r staging)
SECRET_KEY_BASE := $(shell heroku config:get SECRET_KEY_BASE -r staging)
TWITTER_CONSUMER_KEY := $(shell heroku config:get TWITTER_CONSUMER_KEY -r staging)
TWITTER_CONSUMER_SECRET := $(shell heroku config:get TWITTER_CONSUMER_SECRET -r staging)
TWITTER_ACCESS_TOKEN := $(shell heroku config:get TWITTER_ACCESS_TOKEN -r staging)
TWITTER_ACCESS_TOKEN_SECRET := $(shell heroku config:get TWITTER_ACCESS_TOKEN_SECRET -r staging)
YOUTUBE_API_KEY := $(shell heroku config:get YOUTUBE_API_KEY -r staging)

# Targets

.PHONY: deploy
deploy: build run

build:
	docker build --no-cache --build-arg MIX_ENV=staging -t $(IMAGE_NAME) -f Dockerfile .

run:
	docker run -i --name $(IMAGE_NAME) -t --rm -p 4000:4000 \
		-e DATABASE_POOL_SIZE=5 \
		-e DATABASE_URL=$(DATABASE_URL) \
		-e SECRET_KEY_BASE=$(SECRET_KEY_BASE) \
		-e ERLANG_COOKIE=local \
		-e TWITTER_CONSUMER_KEY=$(TWITTER_CONSUMER_KEY) \
		-e TWITTER_CONSUMER_SECRET=$(TWITTER_CONSUMER_SECRET) \
		-e TWITTER_ACCESS_TOKEN=$(TWITTER_ACCESS_TOKEN) \
		-e TWITTER_ACCESS_TOKEN_SECRET=$(TWITTER_ACCESS_TOKEN_SECRET) \
		-e YOUTUBE_API_KEY=$(YOUTUBE_API_KEY) \
		-e FORCE_SSL=false \
		$(IMAGE_NAME) /app/bin/$(BINARY) start

stop:
	docker stop $(IMAGE_NAME)

bash:
	docker run -i --name $(IMAGE_NAME) -t --rm -p 4000:4000 \
		-e DATABASE_POOL_SIZE=5 \
		-e DATABASE_URL=$(DATABASE_URL) \
		-e SECRET_KEY_BASE=$(SECRET_KEY_BASE) \
		-e TWITTER_CONSUMER_KEY=$(TWITTER_CONSUMER_KEY) \
		-e TWITTER_CONSUMER_SECRET=$(TWITTER_CONSUMER_SECRET) \
		-e TWITTER_ACCESS_TOKEN=$(TWITTER_ACCESS_TOKEN) \
		-e TWITTER_ACCESS_TOKEN_SECRET=$(TWITTER_ACCESS_TOKEN_SECRET) \
		-e YOUTUBE_API_KEY=$(YOUTUBE_API_KEY) \
		-e FORCE_SSL=false \
		-e DATABASE_POOL_SIZE=1 \
		$(IMAGE_NAME) bash
