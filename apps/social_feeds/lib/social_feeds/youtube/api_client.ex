defmodule SocialFeeds.Youtube.ApiClient do
  @moduledoc """
  The client for youtube.com API.
  """

  alias SocialFeeds.Youtube.Video

  # require Logger

  @doc """
  Returns videos from YT, ordered desc by publication date.

  ## Examples

      iex> get_new_videos()
      [%Video{}, ...]

  """
  def get_new_videos do
    fetch_videos()
    |> Enum.map(&to_video/1)
  end

  defp fetch_videos do
    [
      %{"title" => "Learning Elixir by Contributing", "img_url" => "/images/mockup/youtube/thumbnail_1.png", "views_count" => "", "posted_ago" => ""},
      %{"title" => "Elixir and OTP for Node.js Developers", "img_url" => "/images/mockup/youtube/thumbnail_2.png", "views_count" => "", "posted_ago" => ""},
      %{"title" => "Mays Community Update", "img_url" => "/images/mockup/youtube/thumbnail_3.png", "views_count" => "", "posted_ago" => ""}
    ]
  end

  defp to_video(video_map) do
    %Video{
      title: video_map["title"],
      img_url: video_map["img_url"],
      views_count: video_map["views_count"],
      posted_ago: video_map["posted_ago"]
    }
  end
end

