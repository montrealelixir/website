# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :social_feeds, :youtube_api_client, [
  youtube_url: "https://www.googleapis.com/youtube/v3",
  channel_id: "UCftyx5k7K_0a3wIGRtE2YQw"
]

import_config "#{Mix.env}.exs"
