defmodule MontrealElixirWeb.TwitterTimelineListener do
  @moduledoc false
  use GenServer
  alias MontrealElixirWeb.Endpoint

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    PubSub.subscribe(self(), "twitter:timeline")
    {:ok, []}
  end

  def handle_info({:new_tweet, tweet}, state) do
    Endpoint.broadcast!("twitter_timeline", "new_tweet", tweet)
    {:noreply, state}
  end

  def handle_info({:all_tweets, tweets}, state) do
    Endpoint.broadcast!("twitter_timeline", "updated_list", %{tweets: tweets})
    {:noreply, state}
  end
end
