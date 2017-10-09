defmodule Twitter.Adapter.ExTwitter do
  @behaviour Twitter.Adapter

  defmodule Data do
    def convert(%ExTwitter.Model.Tweet{id: id, text: text, created_at: timestamp}) do
      %Twitter.Tweet{id: id, text: text, timestamp: timestamp}
    end

    def convert(message), do: message

    def filter_stream(stream) do
      stream
      |> Stream.filter(&valid_message/1)
      |> Stream.map(&convert/1)
    end

    defp valid_message(%ExTwitter.Model.Tweet{}), do: true
    defp valid_message(%ExTwitter.Model.DeletedTweet{}), do: true
    defp valid_message(_), do: false
  end

  @spec fetch_user_timeline() :: [Twitter.Tweet.t]
  def fetch_user_timeline do
    ExTwitter.user_timeline
    |> Enum.map(&Data.convert/1)
  end

  @spec get_user_stream() :: Stream.t
  def get_user_stream do
    ExTwitter.stream_user(with: :user, receive_messages: true, timeout: :infinity)
    |> Data.filter_stream
  end
end
