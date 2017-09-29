defmodule MontrealElixir.Application do
  @moduledoc """
  The MontrealElixir Application Service.

  The montreal_elixir system business domain lives in this application.

  Exposes API to clients such as the `MontrealElixirWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      worker(MontrealElixir.Repo, []),
    ], strategy: :one_for_one, name: MontrealElixir.Supervisor)
  end
end
