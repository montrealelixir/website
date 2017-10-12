defmodule MontrealElixirWeb.TwitterTimelineChannel do
  @moduledoc false
  use Phoenix.Channel

  def join("twitter_timeline", message, socket) do
    send(self(), {:after_join, message})

    {:ok, socket}
  end

  def handle_info({:after_join, _msg}, socket) do
    latest_tweets = Twitter.Timeline.tweets
    push(socket, "updated_list", %{tweets: latest_tweets})

    {:noreply, socket}
  end

  def terminate(_reason, _socket) do
    :ok
  end
end
