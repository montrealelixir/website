use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

###############################################################################
# MontrealElixir
###############################################################################

config :montreal_elixir, MontrealElixir.Repo,
  database: "montreal_elixir_test",
  pool: Ecto.Adapters.SQL.Sandbox

###############################################################################
# MontrealElixirWeb
###############################################################################

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :montreal_elixir_web, MontrealElixirWeb.Endpoint,
  http: [port: 4001],
  server: false

# Handle TravisCI when the file hasn't been copied over yet in the build process
if File.exists?("config/test.secret.exs") do
  import_config "test.secret.exs"
end
