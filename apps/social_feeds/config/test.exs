use Mix.Config

config :social_feeds, :meetup_api_client,
  http_client: SocialFeeds.Test.MeetupApiHttpClient

config :social_feeds, :youtube_api_client,
  http_client: SocialFeeds.Test.YoutubeApiHttpClient
