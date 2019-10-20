use Mix.Config

# Configure the Ecto repository

config :montreal_elixir, MontrealElixir.Repo,
  database: "montreal_elixir_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10")
