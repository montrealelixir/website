import Config

# Do not print debug messages in production
config :logger, level: :info

# Configure the Ecto repository
config :montreal_elixir, MontrealElixir.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE", "5")),
  ssl: true

# Configure the Phoenix endpoint
force_ssl = System.get_env("FORCE_SSL") == "true"
port = String.to_integer(System.get_env("PORT", "4000"))

config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  root: ".",
  server: true,
  http: [port: port],
  url: [
    scheme: if(force_ssl, do: "https", else: "http"),
    host: "localhost",
    port: port
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  check_origin: ["//*.herokuapp.com", "//localhost:#{port}", "//*.montrealelixir.ca"]

# Configure Youtube client
config :social_feeds, :youtube_api_client, api_key: System.get_env("YOUTUBE_API_KEY")

# Conigure ExTwitter
config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
