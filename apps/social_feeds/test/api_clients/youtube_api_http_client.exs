defmodule SocialFeeds.Test.YoutubeApiHttpClient do
  @moduledoc false

  @activities_json File.read!("test/fixtures/youtube_get_activities.json")

  def request(url) do
    url = to_string(url)
    cond do
      String.contains?(url, "error=true") -> {:error, {}}
      true -> {:ok, {[], [], @activities_json}}
    end
  end
end
