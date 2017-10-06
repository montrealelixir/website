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

      iex> get_next_meetup_event()
      %MeetupEvent{}

  """
  def get_next_meetup_event do
    fetch_meetups()
    |> List.first()
    |> to_meetup_event()
  end

  @http Application.get_env(:montreal_elixir, :meetup_api_client)[:http_client] || :httpc
  @url 'https://api.meetup.com/montrealelixir/events?scroll=future_or_past&page=1'
  defp fetch_meetups do
    Logger.info "Meetup API: requesting #{@url}"
    {:ok, {_, _, body}} = @http.request(@url)
    Poison.decode!(body)
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
