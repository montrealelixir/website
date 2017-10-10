defmodule Twitter.Adapter do
  @moduledoc false
  alias Twitter.Tweet

  @doc """
  Returns a list of existing tweets in reverse order (most recent one first).
  """
  @callback fetch_user_timeline() :: [Tweet.t]

  @doc """
  Returns a stream of timeline events (new tweets, deleted tweets, ...).
  """
  @callback get_user_stream() :: Stream.t
end
