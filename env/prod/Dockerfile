### BUILD STAGE
FROM bitwalker/alpine-elixir-phoenix:1.9.2 as builder
RUN mkdir /app

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

# Provide a default for the MIX_ENV, see heroku.yml for more information
ARG MIX_ENV=staging
ENV MIX_ENV ${MIX_ENV}
RUN echo $MIX_ENV

# Copy relevant files
COPY mix.exs mix.lock ./
COPY config config
COPY apps apps

RUN mix do deps.get, deps.compile

# Build assets in production mode:
WORKDIR /app/apps/montreal_elixir_web/assets

# Remove any existing node modules that exist from the host platform. This will cause problems
# if we have modules from the host with OS specific extensions.
RUN rm -rf ./node_modules/*
RUN npm install && ./node_modules/webpack/bin/webpack.js --mode production

WORKDIR /app/apps/montreal_elixir_web
RUN mix phx.digest

WORKDIR /app
RUN mix release montreal_elixir_platform_$MIX_ENV

### RELEASE STAGE
FROM alpine:3.9

# we need bash and openssl for Phoenix
# and Heroku needs curl to perform deployments
RUN apk update \
    apk upgrade --no-cache && \
    apk add --no-cache bash openssl openssh curl python

# EXPOSE is not used by Heroku, it uses the PORT env var and expose the same value
EXPOSE 4000

# Provide a default for the MIX_ENV, see heroku.yml for more information
ARG MIX_ENV=staging
ENV PORT=4000 \
    SHELL=/bin/bash

RUN mkdir /app
WORKDIR /app

COPY --from=builder /app/_build/$MIX_ENV/rel/montreal_elixir_platform_$MIX_ENV/ .

# Copy shell scripts
COPY bin/db_migrate /app/bin/db_migrate

RUN ln -s /app/bin/montreal_elixir_platform_$MIX_ENV /app/bin/montreal_elixir_platform

RUN chown -R root ./releases

USER root

CMD ["/app/bin/montreal_elixir_platform", "start"]
