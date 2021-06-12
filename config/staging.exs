import Config

###############################################################################
# MontrealElixirWeb
##############################################################################

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  url: [
    scheme: "http",
    host: "montreal-elixir-staging.herokuapp.com",
    port: 80
  ],
  check_origin: ["//*.montrealelixir.ca", "//*.herokuapp.com ", "//*.gigalixirapp.com"]
