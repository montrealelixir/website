defmodule MontrealElixir.SocialFeeds.Cache do
  use GenServer

  ## Client API

  defmodule Entry do
    defstruct [:value, :expires_at]
  end

  @doc """
  Starts the cache.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def fetch(key, default_value_function, opts) do
    expires_in = opts[:expires_in] || 600
    case get(key) do
      {:not_found} -> set(key, default_value_function.(), expires_in)
      {:found, result} -> result
    end
  end

  defp get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  defp set(key, value, expires_in) do
    GenServer.call(__MODULE__, {:set, key, value, expires_in})
  end

  ## Server Callbacks

  def handle_call({:get, key}, _from, state) do
    value = case Map.fetch(state, key) do
      :error -> {:not_found}
      {:ok, result} -> if now() >= result.expires_at do
        {:not_found}
      else
        {:found, result.value}
      end
    end
    {:reply, value, state}
  end

  def handle_call({:set, key, value, expires_in}, _from, state) do
    state = Map.put(state,
                    key,
                    %Entry{value: value, expires_at: now() + expires_in})
    {:reply, value, state}
  end

  defp now do
    :os.system_time(:second)
  end
end
