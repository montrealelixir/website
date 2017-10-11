defmodule Twitter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    PubSub.start_link()

    # List all child processes to be supervised
    children = workers(Mix.env)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Twitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp workers(:test), do: []
  defp workers(_env) do
    [
      {Twitter.Timeline, []}
    ]
  end
end
