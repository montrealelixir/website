defmodule MontrealElixir.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      app: :montreal_elixir_platform,
      version: "0.0.0",
      elixir: "1.8.1",
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: ["project.check": :test]
    ]
  end

  def aliases do
    [
      "project.check": [
        "format --dry-run --check-formatted",
        "compile --force --warnings-as-errors",
        "test",
        "credo --strict"
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},

      # OTP Release
      {:distillery, "~> 2.0"}
    ]
  end
end
