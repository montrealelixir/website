defmodule MontrealElixir.Repo do
  use Ecto.Repo, otp_app: :montreal_elixir, adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
  end
end
