use Mix.Config

# Configure the Twitter adapter
config :twitter, adapter: Twitter.Adapter.ExTwitter

# Configure ExTwitter
config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")

# Import environment specific config.
import_config "#{Mix.env()}.exs"
