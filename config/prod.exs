import Config

# Do not print debug messages in production
config :logger, level: :info

###############################################################################
# MontrealElixirWeb
###############################################################################

force_ssl = System.get_env("FORCE_SSL") == "true"
scheme = if force_ssl, do: "https", else: "http"
hostname = System.get_env("HOSTNAME") || "localhost"
port = System.get_env("PORT") || 4000

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  http: [port: port],
  url: [scheme: scheme, host: hostname, port: port],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")
