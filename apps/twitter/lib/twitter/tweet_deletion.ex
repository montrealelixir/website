defmodule Twitter.TweetDeletion do
  @moduledoc false
  @derive Jason.Encoder
  defstruct tweet_id: nil

  @type t :: %__MODULE__{}
end
