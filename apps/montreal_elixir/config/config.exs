use Mix.Config

config :montreal_elixir, ecto_repos: [MontrealElixir.Repo]

import_config "#{Mix.env}.exs"
