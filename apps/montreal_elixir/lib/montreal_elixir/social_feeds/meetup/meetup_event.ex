defmodule MontrealElixir.SocialFeeds.Meetup.Event do
  @moduledoc """
  Struct keeping meetup event attributes.
  """
  defstruct [:name, :utc_datetime, :venue_name, :venue_address, :url]
end
