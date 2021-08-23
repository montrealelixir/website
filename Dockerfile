## BUILDER

FROM elixir:1.12.2-alpine as builder
RUN apk add --no-cache \
    gcc \
    git \
    make \
    musl-dev
RUN mix local.rebar --force && \
    mix local.hex --force

## DEPS

FROM builder as deps
WORKDIR /app

ARG MIX_ENV=staging
ENV MIX_ENV ${MIX_ENV}

COPY mix.* /app/
COPY apps/montreal_elixir/mix.* /app/apps/montreal_elixir/
COPY apps/montreal_elixir_web/mix.* /app/apps/montreal_elixir_web/
COPY apps/social_feeds/mix.* /app/apps/social_feeds/
COPY apps/twitter/mix.* /app/apps/twitter/

RUN mix do deps.get --only $MIX_ENV, deps.compile

## FRONT-END

FROM node:14.4.0-alpine3.12 as frontend
WORKDIR /app
COPY apps/montreal_elixir_web/assets/package*.json /app/
COPY --from=deps /app/deps/phoenix /deps/phoenix
COPY --from=deps /app/deps/phoenix_html /deps/phoenix_html
COPY --from=deps /app/deps/phoenix_live_view /deps/phoenix_live_view
RUN npm ci
COPY apps/montreal_elixir_web/assets /app
RUN npm run deploy

## RELEASER

FROM deps as releaser
WORKDIR /app
COPY config config
COPY apps apps
COPY rel rel
COPY --from=frontend /priv/static apps/montreal_elixir_web/priv/static

ARG MIX_ENV=staging
ENV MIX_ENV ${MIX_ENV}
RUN echo $MIX_ENV
RUN MIX_ENV=$MIX_ENV mix do phx.digest, release montreal_elixir_platform_$MIX_ENV

## RUNNER

FROM alpine:3.11 as runner
# bash and openssl for Phoenix
# and curl to perform deployments on Heroku
RUN apk add --no-cache -U bash libgcc libstdc++ ncurses-libs openssl openssh curl python

WORKDIR /app

# Provide a default for the MIX_ENV, see heroku.yml for more information
ARG MIX_ENV=staging
ENV PORT=4000 \
    SHELL=/bin/bash

COPY --from=releaser /app/_build/$MIX_ENV/rel/montreal_elixir_platform_$MIX_ENV .
RUN ln -s /app/bin/montreal_elixir_platform_$MIX_ENV /app/bin/montreal_elixir_platform

ADD ops/heroku/heroku-exec.sh /app/.profile.d/heroku-exec.sh
RUN chmod a+x /app/.profile.d/heroku-exec.sh

ADD ops/heroku/sh-wrapper.sh /bin/sh-wrapper.sh
RUN chmod a+x /bin/sh-wrapper.sh
RUN rm /bin/sh && ln -s /bin/sh-wrapper.sh /bin/sh

# Copy shell scripts
COPY bin/db_migrate /app/bin/db_migrate

RUN \
  adduser -s /bin/sh -u 1001 -G root -h /app -S -D default && \
  chown -R 1001:0 /app
USER default

# EXPOSE is not used by Heroku, it uses the PORT env var and expose the same value
EXPOSE 4000
CMD ["/app/bin/montreal_elixir_platform", "start"]
