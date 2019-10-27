import Config

# Print only warnings and errors during test
config :logger, level: :warn

###############################################################################
# MontrealElixirWeb
###############################################################################

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  http: [port: 4001],
  server: false

###############################################################################
# SocialFeeds
###############################################################################

config :social_feeds, :youtube_api_client, http_client: SocialFeeds.Test.YoutubeApiHttpClient
config :social_feeds, :meetup_api_client, http_client: SocialFeeds.Test.MeetupApiHttpClient

###############################################################################
# Twitter
###############################################################################

# Configure the Twitter adapter
config :twitter,
  adapter: Twitter.Adapter.Fake,
  workers: []

# Handle TravisCI when the file hasn't been copied over yet in the build process
if File.exists?("config/test.secret.exs") do
  import_config "test.secret.exs"
end
