defmodule Twitter do
  @moduledoc """
  Application for listening to the timeline of a Twitter user.

  Upon start-up, the latest tweets are fetched from Twitter.  The application
  then starts listening to the user's stream.

  New tweets and tweet deletions are published to `PubSub`.
  """
end
