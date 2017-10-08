defmodule MontrealElixir.SocialFeeds.MeetupApiClient do
  @moduledoc """
  The client for meetup.com API.
  """

  alias MontrealElixir.SocialFeeds.MeetupEvent

  require Logger

  @doc """
  Returns the next (upcoming) meetup_event.
  If there is no upcoming event, returns the last (recent) meetup_event.

  ## Examples

      iex> get_next_event()
      %MeetupEvent{}

  """
  def get_next_event do
    get_events(%{scroll: "future_or_past", page: 1})
    |> List.first()
  end

  @doc """
  Returns a list of meetup_events.

  See https://www.meetup.com/meetup_api/docs/:urlname/events/#list for the list of query options.

  ## Examples

      iex> get_events(%{status: "past,upcoming"})
      [%MeetupEvent{}, %MeetupEvent{}, ...]

  """
  def get_events(opts \\ %{}) do
    fetch_meetups(opts)
    |> Enum.map(&to_meetup_event/1)
  end

  @http Application.get_env(:montreal_elixir, :meetup_api_client)[:http_client] || :httpc
  @url "https://api.meetup.com/montrealelixir/events"
  defp fetch_meetups(opts) do
    url = String.to_charlist(@url <> "?" <> URI.encode_query(opts))
    Logger.info "Meetup API: requesting #{url}"

    case @http.request(url) do
      {:ok, {_, _, body}} -> Poison.decode!(body)
      {:error, _} -> []
    end
  end

  defp to_meetup_event(event_map) do
    %MeetupEvent{
      name: event_map["name"],
      utc_datetime: div(event_map["time"], 1000) |> DateTime.from_unix!(),
      venue_name: event_map["venue"]["name"],
      venue_address: event_map["venue"]["address_1"],
      url: event_map["link"]
    }
  end
end
