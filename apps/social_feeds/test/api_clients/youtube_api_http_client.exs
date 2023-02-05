defmodule SocialFeeds.Test.YoutubeApiHttpClient do
  @moduledoc false

  @search_json File.read!("test/fixtures/youtube_get_search.json")

  def request(url) do
    url = to_string(url)

    if String.contains?(url, "error=true") do
      {:error, {}}
    else
      {:ok, {{"HTTP/1.1", 200, "OK"}, [], @search_json}}
    end
  end
end
