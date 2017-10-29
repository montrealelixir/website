use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

config :extwitter, :oauth, [
   consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
   consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
   access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
   access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
]

config :social_feeds, :youtube_api_client,
  api_key: System.get_env("YOUTUBE_API_KEY")
