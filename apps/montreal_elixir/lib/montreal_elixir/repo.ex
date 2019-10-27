defmodule MontrealElixir.Repo do
  use Ecto.Repo,
    otp_app: :montreal_elixir,
    adapter: Ecto.Adapters.Postgres
end
