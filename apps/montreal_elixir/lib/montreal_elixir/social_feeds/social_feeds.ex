defmodule MontrealElixir.SocialFeeds do
  @moduledoc """
  The SocialFeeds context.
  """

  alias MontrealElixir.SocialFeeds.Cache
  alias MontrealElixir.SocialFeeds.MeetupApiClient

  @doc """
  Returns the next (upcoming) meetup_event.
  If there is no upcoming event, returns the last (recent) meetup_event.

  This function does not hit external API if there is an unexpired next_meetup_event in cache.

  ## Examples

      iex> get_next_meetup_event()
      %MeetupEvent{}

  """
  def get_next_meetup_event do
    Cache.fetch(:next_meetup_event,
                fn -> MeetupApiClient.get_next_event() end,
                %{expires_in: 600})
  end
end
