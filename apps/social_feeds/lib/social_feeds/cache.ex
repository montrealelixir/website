defmodule SocialFeeds.Cache do
  @moduledoc """
  Simple map-based cache server with expiring keys.
  """

  @default_expiry_in_msec 600_000

  use GenServer

  ## Client API

  defmodule Entry do
    @moduledoc """
    `Cache.Entry` struct capable of holding any value along with expiration timestamp.
    """

    defstruct [:value, :expires_at]

    @doc """
    Returns an Entry with `value` and expiry time based on `expires_in`
    """
    def build(value, expires_in) do
      %Entry{value: value, expires_at: now() + expires_in}
    end

    @doc """
    Returns `true` if the entry expired accoring to its `expired_in`.
    Returns `false` otherwise.
    """
    def expired?(entry) do
      now() >= entry.expires_at
    end

    defp now do
      :os.system_time(:millisecond)
    end
  end

  @doc """
  Starts the cache.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  @doc """
  Removes all data from cache.
  """
  def clear do
    GenServer.cast(__MODULE__, :clear)
  end

  @doc """
  Returns given key's value from the cache if found.
  Evaluates default_value_function if not.

  Pass :expires_in in opts to change the expiration period.
  Set :expires_in to 0 to expire the key immediatelly (useful for tests).
  The default value is 600 seconds (5 minutes).
  """
  def fetch(key, default_value_function, opts) do
    expires_in = opts[:cache_ttl_in_msec] || @default_expiry_in_msec
    case get(key) do
      :not_found -> set(key, default_value_function.(), expires_in)
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

  @doc """
  Responds to :clear.
  """
  def handle_cast(:clear, _state) do
    {:noreply, %{}}
  end

  @doc """
  Responds to :get.

  Returns :not_found if the key is not stored or if its value expired.
  Returns {:found, value} if the key is stored and still valid.
  """
  def handle_call({:get, key}, _from, state) do
    value = case Map.fetch(state, key) do
      :error -> :not_found
      {:ok, result} -> if Entry.expired?(result) do
        :not_found
      else
        {:found, result.value}
      end
    end
    {:reply, value, state}
  end

  @doc """
  Responds to :set.

  Puts the key + value in the state map along with it's expiration timestamp.
  """
  def handle_call({:set, key, value, expires_in}, _from, state) do
    entry = Entry.build(value, expires_in)
    state = Map.put(state, key, entry)

    {:reply, value, state}
  end
end
