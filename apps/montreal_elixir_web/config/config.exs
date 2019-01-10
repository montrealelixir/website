# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# General application configuration
config :montreal_elixir_web,
  namespace: MontrealElixirWeb,
  ecto_repos: [MontrealElixir.Repo]

# Configures the endpoint
force_ssl = System.get_env("FORCE_SSL") == "true"
port = String.to_integer(System.get_env("PORT") || "4000")

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  http: [port: port],
  url: [
    scheme: if(force_ssl, do: "https", else: "http"),
    host: System.get_env("HOSTNAME"),
    port: port
  ],
  pubsub: [name: MontrealElixirWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  render_errors: [view: MontrealElixirWeb.ErrorView, accepts: ~w(html json)],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :montreal_elixir_web, :generators, context_app: :montreal_elixir

# Import environment specific config.
import_config "#{Mix.env()}.exs"
