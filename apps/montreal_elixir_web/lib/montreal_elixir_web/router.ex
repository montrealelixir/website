defmodule MontrealElixirWeb.Router do
  use MontrealElixirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug :fetch_live_flash
    plug :put_root_layout, {MontrealElixirWeb.LayoutView, :root}
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  import Phoenix.LiveDashboard.Router

  scope "/", MontrealElixirWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/mockup", PageController, :mockup)

    live "/live_example", PageLive, :index

    # Let the world see how cool LiveDashboard is
    live_dashboard "/dashboard", metrics: MontrealElixirWeb.Telemetry
  end

  # Other scopes may use custom stacks.
  # scope "/api", MontrealElixirWeb do
  #   pipe_through :api
  # end
end
