defmodule MontrealElixirWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(MontrealElixirWeb.Endpoint, []),
      # Start your own worker by calling: MontrealElixirWeb.Worker.start_link(arg1, arg2, arg3)
      # worker(MontrealElixirWeb.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MontrealElixirWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MontrealElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
