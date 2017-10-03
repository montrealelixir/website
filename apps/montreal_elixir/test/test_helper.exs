Code.require_file "montreal_elixir/social_feeds/api_clients/meetup_api_http_client.exs", __DIR__
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(MontrealElixir.Repo, :manual)
