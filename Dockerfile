#
# Step 1 - build the OTP binary
#
FROM elixir:1.8.1-alpine AS builder

ARG APP_NAME
ARG APP_VERSION
ARG MIX_ENV=prod

ENV APP_NAME=${APP_NAME} \
    APP_VERSION=${APP_VERSION} \
    MIX_ENV=${MIX_ENV}

WORKDIR /montreal-elixir

# This step installs all the build tools we'll need
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache openssl-dev nodejs npm

RUN mix local.rebar --force && \
    mix local.hex --force

COPY . .
RUN mix deps.get --only ${MIX_ENV}
RUN mix compile

RUN npm ci --prefix apps/montreal_elixir_web/assets
RUN mix phx.digest

RUN mkdir -p /opt/build && \
    mix release --verbose && \
    cp _build/${MIX_ENV}/rel/${APP_NAME}/releases/${APP_VERSION}/${APP_NAME}.tar.gz /opt/build

RUN cd /opt/build && \
    tar -xzf ${APP_NAME}.tar.gz && \
    rm ${APP_NAME}.tar.gz

#
# Step 2 - build a lean runtime container
#
FROM alpine:3.9

ARG APP_NAME
ENV APP_NAME=${APP_NAME}

# Update kernel and install runtime dependencies
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add bash openssl

WORKDIR /opt/montreal_elixir

# Copy the OTP binary from the build step
COPY --from=builder /opt/build .

# Copy the entrypoint script
COPY priv/scripts/docker-entrypoint.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

# Create a non-root user
RUN adduser -D montreal_elixir && \
    chown -R montreal_elixir: /opt/montreal_elixir

USER montreal_elixir

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["foreground"]
