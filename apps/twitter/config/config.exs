use Mix.Config

# Configure ExTwitter
config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")

# Configure the Twitter adapter @behaviour
config :twitter, adapter: Twitter.Adapter.ExTwitter

# Import environment specific config.
import_config "#{Mix.env()}.exs"
