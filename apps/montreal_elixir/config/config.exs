use Mix.Config

config :montreal_elixir, ecto_repos: [MontrealElixir.Repo]

# Configure the Ecto repository
config :montreal_elixir, MontrealElixir.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10"),
  ssl: System.get_env("FORCE_SSL") == "true"

# Import environment specific config.
import_config "#{Mix.env()}.exs"
