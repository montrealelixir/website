defmodule Twitter.Timeline do
  use GenServer
  alias Twitter.Tweet

  # Public interface

  def start_link(opts \\ []) do
    adapter = Application.get_env(:twitter, :adapter, opts[:adapter])
    GenServer.start_link(__MODULE__, [adapter], name: __MODULE__)
  end

  def init([adapter]) do
    # Defer initialization to prevent timeout
    GenServer.cast(self(), :init)

    {:ok, %{adapter: adapter, tweets: []}}
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

    {:noreply, new_state}
  end

  def handle_call(:list, _from, %{tweets: tweets} = state) do
    {:reply, tweets, state}
  end
end
