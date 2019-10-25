import Config

# Do not print debug messages in production
config :logger, level: :info

###############################################################################
# MontrealElixirWeb
###############################################################################

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: ["https://*.herokuapp.com"]
