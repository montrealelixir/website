use Mix.Config

config :montreal_elixir, ecto_repos: [MontrealElixir.Repo]

config :montreal_elixir, MontrealElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10")

config :montreal_elixir, :meetup_api_client,
  meetup_url: "https://api.meetup.com/montrealelixir"

# Import environment specific config.
import_config "#{Mix.env}.exs"
