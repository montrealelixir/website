defmodule MontrealElixir.SocialFeeds.Cache do
  use GenServer

  ## Client API

  @doc """
  Starts the cache.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def fetch(server, key, default_value_function, _opts) do
    GenServer.call(server, {:set, key, default_value_function.()})
  end

  ## Server Callbacks

  def handle_call({:set, _key, value}, _from, state) do
    {:reply, value, state}
  end
end
