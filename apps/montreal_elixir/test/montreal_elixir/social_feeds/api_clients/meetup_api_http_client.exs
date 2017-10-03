defmodule MontrealElixir.SocialFeeds.Test.MeetupApiHTTPClient do
  @meetup_json File.read!("test/montreal_elixir/fixtures/meetup_upcoming_events.json")

  def request(_url) do
    {:ok, {[], [], @meetup_json}}
  end
end
