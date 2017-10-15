defmodule SocialFeeds.Meetup.ApiClientTest do
  use ExUnit.Case, async: true

  alias SocialFeeds.Meetup.ApiClient
  alias SocialFeeds.Meetup.Event

  describe "get_next_event/0" do
    @tag :capture_log
    test "returns the next meetup_event" do
      {:ok, expected_time, _offset} = DateTime.from_iso8601("2017-10-11 22:30:00Z")
      event = %Event{
        name: "Montreal Elixir Meetup",
        utc_datetime: expected_time,
        venue_name: "Shopify Montreal",
        venue_address: "490 rue de la Gauchetiere Ouest",
        url: "https://www.meetup.com/montrealelixir/events/243582390/"
      }

      assert ApiClient.get_next_event() == event
    end
  end

  describe "get_events/1" do
    @tag :capture_log
    test "returns list of Events" do
      result = ApiClient.get_events() |> Enum.map(&(&1.name))

      assert result == ["Meetup 1", "Meetup 2"]
    end

    @tag :capture_log
    test "returns empty list on API error" do
      assert ApiClient.get_events(%{error: true}) == []
    end
  end
end
