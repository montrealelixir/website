defmodule Twitter.Adapter.ExTwitter do
  @moduledoc false
  @behaviour Twitter.Adapter

  defmodule State do
    @moduledoc false

    def convert(%ExTwitter.Model.Tweet{id: id, text: text, created_at: timestamp}) do
      %Twitter.Tweet{id: id, text: text, timestamp: timestamp}
    end

    def convert(%ExTwitter.Model.DeletedTweet{status: %{id: id}}) do
      %Twitter.TweetDeletion{tweet_id: id}
    end

    def convert(message), do: message

    def filter_stream(stream) do
      stream
      |> Stream.filter(&valid_message/1)
      |> Stream.map(&convert/1)
    end

    defp valid_message(%ExTwitter.Model.Tweet{}), do: true
    defp valid_message(%ExTwitter.Model.DeletedTweet{}), do: true
    defp valid_message(_message), do: false
  end

  @spec fetch_user_timeline() :: [Twitter.Tweet.t]
  def fetch_user_timeline do
    ExTwitter.user_timeline
    |> Enum.map(&State.convert/1)
  end

  @spec get_user_stream() :: Stream.t
  def get_user_stream do
    options = [with: :user, receive_messages: true, timeout: :infinity]

    options
    |> ExTwitter.stream_user
    |> State.filter_stream
  end
end
