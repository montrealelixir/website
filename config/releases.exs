import Config

###############################################################################
# Elixir Config
##############################################################################

# Do not print debug messages in production
config :logger, level: :info

###############################################################################
# MontrealElixir
##############################################################################

config :montreal_elixir, MontrealElixir.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "5")),
  ssl: true

###############################################################################
# MontrealElixirWeb
##############################################################################

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  root: ".",
  server: true,
  http: [port: String.to_integer(System.get_env("PORT", "4000"))],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

###############################################################################
# SocialFeeds
##############################################################################

config :social_feeds, :youtube_api_client, api_key: System.get_env("YOUTUBE_API_KEY")

###############################################################################
# Twitter
##############################################################################

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
