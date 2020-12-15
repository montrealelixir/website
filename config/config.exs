import Config

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
  pubsub_server: MontrealElixir.PubSub,
  url: [
    scheme: if(force_ssl, do: "https", else: "http"),
    host: System.get_env("HOSTNAME") || "localhost",
    port: port
  ],
  render_errors: [view: MontrealElixirWeb.ErrorView, accepts: ~w(html json)],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :montreal_elixir_web, :generators, context_app: :montreal_elixir

###############################################################################
# SocialFeeds
###############################################################################

config :social_feeds, :youtube_api_client,
  youtube_api_url: "https://www.googleapis.com/youtube/v3",
  youtube_url: "https://youtube.com",
  channel_id: "UCftyx5k7K_0a3wIGRtE2YQw"

config :social_feeds, :meetup_api_client, meetup_url: "https://api.meetup.com/montrealelixir"

###############################################################################
# Twitter
###############################################################################

# Configure the Twitter adapter
config :twitter, adapter: Twitter.Adapter.ExTwitter

# Import environment specific config.
import_config "#{Mix.env()}.exs"
