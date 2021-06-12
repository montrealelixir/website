import Config

###############################################################################
# MontrealElixirWeb
##############################################################################

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  # `force_ssl` is compiled into the SSL plug, so cannot be in config/releases.exs which is for boot-time config only.
  force_ssl: [hsts: true, rewrite_on: [:x_forwarded_proto]],
  url: [
    scheme: "https",
    host: "montrealelixir.ca",
    port: 443
  ],
  check_origin: ["//*.montrealelixir.ca", "//*.herokuapp.com ", "//*.gigalixirapp.com"]
