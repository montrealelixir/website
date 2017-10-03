defmodule MontrealElixir.SocialFeeds.MeetupApiClientTest do
  use MontrealElixir.DataCase

  alias MontrealElixir.SocialFeeds.MeetupApiClient

  describe "get_next_meetup_event/0" do
    alias MontrealElixir.SocialFeeds.MeetupEvent

    test "returns the next meetup_event" do
      {:ok, expected_time, _offset} = DateTime.from_iso8601("2017-10-11 22:30:00Z")
      event = %MeetupEvent{
        name: "Montreal Elixir Meetup",
        utc_datetime: expected_time,
        venue_name: "Shopify Montreal",
        venue_address: "490 rue de la Gauchetiere Ouest",
        url: "https://www.meetup.com/montrealelixir/events/243582390/"
      }

      assert MeetupApiClient.get_next_meetup_event() == event
    end
  end
end
