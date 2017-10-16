use Mix.Config

# Configure your database
config :montreal_elixir, MontrealElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "montreal_elixir_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
