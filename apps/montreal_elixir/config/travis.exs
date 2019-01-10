use Mix.Config

# Configure the Ecto repository
config :montreal_elixir, MontrealElixir.Repo,
  database: "montreal_elixir_test",
  pool: Ecto.Adapters.SQL.Sandbox
