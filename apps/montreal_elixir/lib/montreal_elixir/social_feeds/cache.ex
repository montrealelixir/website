defmodule MontrealElixir.SocialFeeds.Cache do
  use GenServer

  ## Client API

  @doc """
  Starts the cache.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def fetch(key, default_value_function, _opts) do
    case get(key) do
      {:not_found} -> set(key, default_value_function.())
      {:found, result} -> result
    end
  end

  defp get(key) do
    case GenServer.call(__MODULE__, {:get, key}) do
      :error -> {:not_found}
      {:ok, result} -> {:found, result}
    end
  end

  defp set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  ## Server Callbacks

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch(state, key), state}
  end

  def handle_call({:set, key, value}, _from, state) do
    state = Map.put(state, key, value)
    {:reply, value, state}
  end
end
