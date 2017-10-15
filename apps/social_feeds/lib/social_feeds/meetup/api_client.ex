if Mix.env == :test || Mix.env == :travis do
  Code.require_file("../../../test/api_clients/meetup_api_http_client.exs", __DIR__)
end

defmodule SocialFeeds.Meetup.ApiClient do
  @moduledoc """
  The client for meetup.com API.
  """

  alias SocialFeeds.Meetup.Event

  require Logger

  @doc """
  Returns the next (upcoming) meetup_event.
  If there is no upcoming event, returns the last (recent) meetup_event.

  ## Examples

      iex> get_next_event()
      %Event{}

  """
  def get_next_event do
    %{scroll: "future_or_past", page: 1}
    |> get_events()
    |> List.first()
  end

  @doc """
  Returns a list of meetup_events.

  See https://www.meetup.com/meetup_api/docs/:urlname/events/#list for the list of query options.

  ## Examples

      iex> get_events(%{status: "past,upcoming"})
      [%Event{}, ...]

  """
  def get_events(opts \\ %{}) do
    opts
    |> fetch_meetups()
    |> Enum.map(&to_meetup_event/1)
  end

  @http Application.get_env(:social_feeds, :meetup_api_client)[:http_client] || :httpc
  defp fetch_meetups(opts) do
    url = String.to_charlist(meetup_events_url() <> "?" <> URI.encode_query(opts))
    Logger.info "Meetup API: requesting #{url}"

    case @http.request(url) do
      {:ok, {_, _, body}} -> Poison.decode!(body)
      {:error, _} -> []
    end
  end

  defp to_meetup_event(event_map) do
    %Event{
      name: event_map["name"],
      utc_datetime: event_map["time"] |> div(1000) |> DateTime.from_unix!(),
      venue_name: event_map["venue"]["name"],
      venue_address: event_map["venue"]["address_1"],
      url: event_map["link"]
    }
  end

  defp meetup_events_url, do: base_url() <> "/events"

  def base_url, do: Application.get_env(:montreal_elixir, :meetup_api_client)[:meetup_url]
end
