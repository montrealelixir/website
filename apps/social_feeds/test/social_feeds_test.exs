defmodule SocialFeedsTest do
  use ExUnit.Case

  alias SocialFeeds.Cache

  describe "get_next_meetup_event/1" do
    setup do
      Cache.clear()
    end

    @tag :capture_log
    test "returns the next meetup_event" do
      {:ok, expected_time, _offset} = DateTime.from_iso8601("2017-10-11 22:30:00Z")
      event = %SocialFeeds.Meetup.Event{
        name: "Montreal Elixir Meetup",
        utc_datetime: expected_time,
        venue_name: "Shopify Montreal",
        venue_address: "490 rue de la Gauchetiere Ouest",
        url: "https://www.meetup.com/montrealelixir/events/243582390/"
      }

      assert SocialFeeds.get_next_meetup_event() == event
    end

    @tag :capture_log
    test "allows to specify custom caching period" do
      SocialFeeds.get_next_meetup_event(%{cache_ttl_in_msec: 0})

      result = Cache.fetch(:next_meetup_event, fn -> :new_value end, %{})
      assert result == :new_value
    end

    test "returns the next meetup_event from cache" do
      Cache.fetch(:next_meetup_event, fn -> :cached_value end, %{cache_ttl_in_msec: 600_000})

      assert SocialFeeds.get_next_meetup_event() == :cached_value
    end
  end
end
