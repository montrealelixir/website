if Mix.env() == :test do
  Code.require_file("../../../test/api_clients/youtube_api_http_client.exs", __DIR__)
end

defmodule SocialFeeds.Youtube.ApiClient do
  @moduledoc """
  The client for youtube.com API.
  """

  alias SocialFeeds.Youtube.Video

  require Logger

  @doc """
  Returns the recent 3 videos from YT, ordered desc by publication date.

  ## Examples

      iex> get_new_videos()
      [%Video{}, ...]

  """
  def get_new_videos do
    get_videos(%{maxResults: 3, part: "snippet,contentDetails"})
  end

  @doc """
  Returns videos from YT, ordered desc by publication date.

  See https://developers.google.com/youtube/v3/docs/activities/list for the list of query options.

  ## Examples

      iex> get_videos(%{part: "id,snippet,contentDetails"})
      [%Video{}, ...]

  """
  def get_videos(opts \\ %{}) do
    opts
    |> fetch_videos()
    |> Enum.map(&to_video/1)
  end

  @http Application.get_env(:social_feeds, :youtube_api_client)[:http_client] || :httpc
  defp fetch_videos(opts) do
    opts = Map.merge(opts, %{channelId: channel_id(), key: api_key()})
    url = youtube_activities_url() <> "?" <> URI.encode_query(opts)
    Logger.info("YouTube API: requesting #{redact_sensitive_data(url)}")

    case @http.request(String.to_charlist(url)) do
      {:ok, {{_http_version, 200, _reason}, _headers, body}} -> Poison.decode!(body)["items"]
      _ -> []
    end
  end

  defp to_video(video_map) do
    {:ok, published_at, _} = DateTime.from_iso8601(video_map["snippet"]["publishedAt"])

    %Video{
      title: video_map["snippet"]["title"],
      url: youtube_watch_url() <> "?v=" <> video_map["contentDetails"]["upload"]["videoId"],
      img_url: video_map["snippet"]["thumbnails"]["default"]["url"],
      published_at: published_at
    }
  end

  defp youtube_activities_url, do: base_url() <> "/activities"
  defp youtube_watch_url, do: public_url() <> "/watch"

  defp base_url, do: Application.get_env(:social_feeds, :youtube_api_client)[:youtube_api_url]
  defp public_url, do: Application.get_env(:social_feeds, :youtube_api_client)[:youtube_url]
  defp channel_id, do: Application.get_env(:social_feeds, :youtube_api_client)[:channel_id]
  defp api_key, do: Application.get_env(:social_feeds, :youtube_api_client)[:api_key]

  defp redact_sensitive_data(str), do: String.replace(str, ~r/key=([^&\s]+)/, "key=[REDACTED]")
end
