# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

###############################################################################
# MontrealElixir
###############################################################################

config :montreal_elixir, ecto_repos: [MontrealElixir.Repo]

###############################################################################
# MontrealElixirWeb
###############################################################################

config :phoenix, :json_library, Jason

# General application configuration
config :montreal_elixir_web, namespace: MontrealElixirWeb

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
