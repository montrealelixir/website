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
    %MeetupEvent{
      name: "Montreal Elixir Meetup",
      time: "Wed June 14 at 6:30 PM",
      venue_name: "Shopify Montreal",
      venue_address: "490 rue de la Gauchetiere Ouest",
      url: "https://www.meetup.com/montrealelixir/events/240183837/"
    }
  end
end
