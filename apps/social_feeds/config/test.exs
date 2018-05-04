use Mix.Config

# Configure SocialFeeds with mocked HTTP clients
config :social_feeds, :meetup_api_client, http_client: SocialFeeds.Test.MeetupApiHttpClient

config :social_feeds, :youtube_api_client, http_client: SocialFeeds.Test.YoutubeApiHttpClient
