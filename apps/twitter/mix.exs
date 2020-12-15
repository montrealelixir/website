defmodule Twitter.Mixfile do
  use Mix.Project

  def project do
    [
      app: :twitter,
      version: "0.0.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.11.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Twitter.Application, []},
      extra_applications: [:logger, :extwitter]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:blocking_queue, "~> 1.0"},
      {:oauther, "~> 1.1"},
      {:extwitter, "~> 0.8"},
      {:jason, "~> 1.0"},
      {:pubsub, "~> 1.0"}
    ]
  end
end
