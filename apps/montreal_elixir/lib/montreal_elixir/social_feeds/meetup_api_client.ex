defmodule MontrealElixir.SocialFeeds.MeetupApiClient do
  @moduledoc """
  The client for meetup.com API.
  """

  alias MontrealElixir.SocialFeeds.MeetupEvent

  @doc """
  Returns the next (upcoming) meetup_event.

  ## Examples

      iex> get_next_meetup_event()
      %MeetupEvent{}

  """
  def get_next_meetup_event do
    fetch_meetups()
    |> get_next_meetup()
  end

  @http Application.get_env(:montreal_elixir, :meetup_api_client)[:http_client] || :httpc
  @url 'https://api.meetup.com/montrealelixir/events?scroll=future_or_past&page=1'
  defp fetch_meetups do
    {:ok, {_, _, body}} = @http.request(@url)
    {:ok, events} = Poison.decode(body)
    events
  end

  defp get_next_meetup(events) do
    [event | _] = events
    to_meetup_event(event)
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
