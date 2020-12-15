defmodule SocialFeeds.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {SocialFeeds.Cache, [name: SocialFeeds.Cache]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
