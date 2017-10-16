use Mix.Config

config :social_feeds, :meetup_api_client,
  http_client: SocialFeeds.Test.MeetupApiHttpClient
