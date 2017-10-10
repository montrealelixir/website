defmodule Twitter.Timeline do
  @moduledoc """
  Module for keeping track of the Twitter timeline of a user.  It fetches
  the most recent tweet when initializing and listens to the user stream.
  New tweets are published to a PubSub topic.  When a tweet is deleted,
  the updated list of tweets is published to PubSub topic.
  """
  use GenServer
  alias Twitter.{Tweet, TweetDeletion}
  require Logger

  # Public interface

  def start_link(opts \\ []) do
    adapter = Application.get_env(:twitter, :adapter, opts[:adapter])
    topic = Keyword.get(opts, :topic, "twitter:timeline")
    GenServer.start_link(__MODULE__, [adapter, topic], name: __MODULE__)
  end

  def init([adapter, topic]) do
    # Defer initialization to prevent timeout
    GenServer.cast(self(), :init)

    {:ok, %{adapter: adapter, tweets: [], topic: topic}}
  end

  @doc """
  Returns the tweets, the first one being the most recent one.
  """
  @spec tweets :: [Tweet.t]
  def tweets do
    GenServer.call(__MODULE__, :list)
  end

  # Server Callbacks

  def handle_cast(:init, %{adapter: adapter} = state) do
    latest_tweets = adapter.fetch_user_timeline()
    new_state = %{state | tweets: latest_tweets}
    listen_to_user_stream(adapter)

    {:noreply, new_state}
  end

  def handle_call(:list, _from, %{tweets: tweets} = state) do
    {:reply, tweets, state}
  end

  def handle_call({:push, tweet}, _from, %{tweets: tweets, topic: topic} = state) do
    PubSub.publish(topic, {:new_tweet, tweet})

    {:reply, :ok, %{state | tweets: [tweet | tweets]}}
  end

  def handle_call({:remove, tweet_id}, _from, %{tweets: tweets} = state) do
    new_tweets = Enum.filter(tweets, &(&1.id != tweet_id))
    PubSub.publish(state.topic, {:all_tweets, new_tweets})

    {:reply, :ok, %{state | tweets: new_tweets}}
  end

  defp listen_to_user_stream(adapter) do
    stream = adapter.get_user_stream()
    timeline = self()

    Task.start_link(fn -> read_stream(stream, timeline) end)
  end

  defp read_stream(stream, timeline) do
    for message <- stream do
      case determine_call(message) do
        :noop -> :ok
        action -> GenServer.call(timeline, action)
      end
    end
  end

  defp determine_call(%Tweet{} = tweet), do: {:push, tweet}
  defp determine_call(%TweetDeletion{tweet_id: tweet_id}), do: {:remove, tweet_id}
  defp determine_call(message) do
    Logger.debug fn -> "Unhandled message #{inspect(message)}" end
    :noop
  end
end
