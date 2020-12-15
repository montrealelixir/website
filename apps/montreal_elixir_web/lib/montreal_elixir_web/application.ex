defmodule MontrealElixirWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Define workers and child supervisors to be supervised
    children = [
      MontrealElixirWeb.Telemetry,
      MontrealElixirWeb.Endpoint,
      MontrealElixirWeb.TwitterTimelineListener
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
