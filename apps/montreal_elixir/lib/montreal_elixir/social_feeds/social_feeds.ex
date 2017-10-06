defmodule MontrealElixir.SocialFeeds do
  @moduledoc """
  The SocialFeeds context.
  """

  alias MontrealElixir.SocialFeeds.MeetupApiClient

  @doc """
  Returns the next (upcoming) meetup_event.
  If there is no upcoming event, returns the last (recent) meetup_event.

  ## Examples

      iex> get_next_meetup_event()
      %MeetupEvent{}

  """
  def get_next_meetup_event do
    MeetupApiClient.get_next_meetup_event()
  end
end
