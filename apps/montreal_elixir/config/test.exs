use Mix.Config

# Configure your database
config :montreal_elixir, MontrealElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "montreal_elixir_test",
  pool: Ecto.Adapters.SQL.Sandbox
