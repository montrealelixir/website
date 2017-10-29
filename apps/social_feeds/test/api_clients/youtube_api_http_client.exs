defmodule SocialFeeds.Test.YoutubeApiHttpClient do
  @moduledoc false

  @activities_json File.read!("test/fixtures/youtube_get_activities.json")

  def request(url) do
    url = to_string(url)
    if String.contains?(url, "error=true") do
      {:error, {}}
    else
      {:ok, {[], [], @activities_json}}
    end
  end
end
