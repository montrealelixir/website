defmodule MontrealElixir.SocialFeeds.MeetupApiClientTest do
  use MontrealElixir.DataCase

  alias MontrealElixir.SocialFeeds.MeetupApiClient

  describe "get_next_meetup_event/0" do
    alias MontrealElixir.SocialFeeds.MeetupEvent

    test "returns the next meetup_event" do
      event = %MeetupEvent{
        name: "Montreal Elixir Meetup",
        time: "Wed June 14 at 6:30 PM",
        venue_name: "Shopify Montreal",
        venue_address: "490 rue de la Gauchetiere Ouest",
        url: "https://www.meetup.com/montrealelixir/events/240183837/"
      }

      assert MeetupApiClient.get_next_meetup_event == event
    end
  end
end
