defmodule MontrealElixir.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      version: "0.0.0",
      elixir: "~> 1.12.0",
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: ["project.check": :test],
      releases: [
        montreal_elixir_platform_staging: [
          include_executables_for: [:unix],
          include_erts: true,
          version: "0.0.0",
          applications: [
            runtime_tools: :permanent,
            montreal_elixir: :permanent,
            social_feeds: :permanent,
            twitter: :permanent,
            montreal_elixir_web: :permanent
          ]
        ],
        montreal_elixir_platform_prod: [
          include_executables_for: [:unix],
          include_erts: true,
          version: "0.0.0",
          applications: [
            runtime_tools: :permanent,
            montreal_elixir: :permanent,
            social_feeds: :permanent,
            twitter: :permanent,
            montreal_elixir_web: :permanent
          ]
        ]
      ]
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

  defp deps do
    [
      {:credo, "~> 1.5.0", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end
end
