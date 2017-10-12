defmodule Twitter.Adapter.Fake do
  @moduledoc false
  @behaviour Twitter.Adapter

  # Public interface

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  def init(:ok) do
    # Use blocking queue to simulate a twitter stream
    {:ok, queue} = BlockingQueue.start_link(:infinity)

    {:ok, %{queue: queue, tweets: []}}
  end

  @spec fetch_user_timeline() :: [Twitter.Tweet.t]
  def fetch_user_timeline do
    GenServer.call(__MODULE__, :tweets)
  end

  @spec get_user_stream() :: Stream.t
  def get_user_stream do
    GenServer.call(__MODULE__, :get_stream)
  end

  # Functions for simulating a real adapter

  def put_tweets(tweets) do
    GenServer.call(__MODULE__, {:set_tweets, tweets})
  end

  def stream_tweet(tweet) do
    GenServer.call(__MODULE__, {:stream_tweet, tweet})
  end

  # Server Callbacks

  def handle_call(:tweets, _from, %{tweets: tweets} = state) do
    {:reply, tweets, state}
  end

  def handle_call(:get_stream, _from, %{queue: pid} = state) do
    stream = BlockingQueue.pop_stream(pid)

    {:reply, stream, state}
  end

  def handle_call({:set_tweets, tweets}, _from, state) do
    {:reply, tweets, %{state | tweets: tweets}}
  end

  def handle_call({:stream_tweet, tweet}, _from, %{queue: pid} = state) do
    BlockingQueue.push(pid, tweet)

    {:reply, :ok, state}
  end
end
