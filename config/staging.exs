import Config

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  url: [
    scheme: "http",
    host: "montreal-elixir-staging.herokuapp.com",
    port: 80
  ],
  check_origin: ["//*.herokuapp.com"]
