use Mix.Config

config :montreal_elixir, ecto_repos: [MontrealElixir.Repo]

config :montreal_elixir, :meetup_api_client,
  meetup_url: "https://api.meetup.com/montrealelixir"

import_config "#{Mix.env}.exs"
