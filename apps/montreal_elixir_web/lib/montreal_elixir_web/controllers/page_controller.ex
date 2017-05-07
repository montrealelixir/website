defmodule MontrealElixir.Web.PageController do
  use MontrealElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
