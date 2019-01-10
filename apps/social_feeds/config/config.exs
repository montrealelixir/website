use Mix.Config

config :social_feeds, :youtube_api_client,
  api_key: System.get_env("YOUTUBE_API_KEY"),
  youtube_api_url: "https://www.googleapis.com/youtube/v3",
  youtube_url: "https://youtube.com",
  channel_id: "UCftyx5k7K_0a3wIGRtE2YQw"

config :social_feeds, :meetup_api_client, meetup_url: "https://api.meetup.com/montrealelixir"

# Import environment specific config.
import_config "#{Mix.env()}.exs"
