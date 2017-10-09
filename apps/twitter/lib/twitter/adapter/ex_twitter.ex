defmodule Twitter.Adapter.ExTwitter do
  @behaviour Twitter.Adapter

  defmodule Data do
    def convert(%ExTwitter.Model.Tweet{id: id, text: text, created_at: timestamp}) do
      %Twitter.Tweet{id: id, text: text, timestamp: timestamp}
    end
  end

  @spec fetch_user_timeline() :: [Twitter.Tweet.t]
  def fetch_user_timeline do
    ExTwitter.user_timeline
    |> Enum.map(&Data.convert/1)
  end

  @spec get_user_stream() :: Stream.t
  def get_user_stream do
  end
end
