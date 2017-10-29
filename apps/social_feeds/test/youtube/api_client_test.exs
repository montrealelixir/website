defmodule SocialFeeds.Youtube.ApiClientTest do
  use ExUnit.Case, async: true

  alias SocialFeeds.Youtube.ApiClient
  alias SocialFeeds.Youtube.Video

  describe "get_new_videos/0" do
    @tag :capture_log
    test "returns the recent 3 videos" do
      assert length(ApiClient.get_new_videos()) == 3
    end

    @tag :capture_log
    test "returns the proper Video data struct" do
      video = %Video{
        title: "Phoenix 1.3 and Contexts",
        published_at: "2017-09-19T12:23:32.000Z",
        img_url: "https://i.ytimg.com/vi/y25Suot7vto/default.jpg"
      }
      resp = ApiClient.get_new_videos()

      assert List.first(resp) == video
    end
  end

  describe "get_videos/1" do
    @tag :capture_log
    test "returns list of Events" do
      titles = [
        "Phoenix 1.3 and Contexts",
        "Why We Chose Elixir and How It Helped Tackle Concurrency and Scalability",
        "Montreal Elixir: Community Update"
      ]

      result = ApiClient.get_videos() |> Enum.map(&(&1.title))

      assert result == titles
    end

    @tag :capture_log
    test "returns empty list on API error" do
      assert ApiClient.get_videos(%{error: true}) == []
    end
  end
end
