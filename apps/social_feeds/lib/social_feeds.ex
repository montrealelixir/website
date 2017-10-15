defmodule SocialFeeds do
  @moduledoc """
  The SocialFeeds app endpoint functions.
  """

  alias SocialFeeds.Cache

  @doc """
  Returns the next (upcoming) meetup_event.
  If there is no upcoming event, returns the last (recent) meetup_event.

  This function does not hit external API if there is an unexpired next_meetup_event in cache.

  ## Examples

      iex> get_next_meetup_event()
      %SocialFeeds.Meetup.Event{}

  """
  def get_next_meetup_event do
    Cache.fetch(:next_meetup_event,
                fn -> SocialFeeds.Meetup.ApiClient.get_next_event() end,
                %{cache_ttl_in_msec: 600_000})
  end
end
