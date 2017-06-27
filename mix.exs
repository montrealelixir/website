defmodule MontrealElixir.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        "project.check": :test
      ]
    ]
  end

  def aliases do
    [
      "project.check": [
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
      {:credo, "~> 0.8.1", only: [:dev, :test], runtime: false}
    ]
  end
end

