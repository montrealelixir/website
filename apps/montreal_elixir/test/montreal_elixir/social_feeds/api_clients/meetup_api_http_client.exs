defmodule MontrealElixir.SocialFeeds.Test.MeetupApiHTTPClient do
  @moduledoc false

  @meetup_json File.read!("test/montreal_elixir/fixtures/meetup_upcoming_events.json")
  @meetups_json File.read!("test/montreal_elixir/fixtures/meetup_get_events.json")

  def request(url) do
    url = to_string(url)
    cond do
      String.contains?(url, "page=1") -> {:ok, {[], [], @meetup_json}}
      String.contains?(url, "error=true") -> {:error, {}}
      true -> {:ok, {[], [], @meetups_json}}
    end
  end
end
