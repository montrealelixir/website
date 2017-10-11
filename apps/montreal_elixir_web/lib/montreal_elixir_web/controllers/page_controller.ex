defmodule MontrealElixirWeb.PageController do
  use MontrealElixirWeb, :controller

  alias MontrealElixir.SocialFeeds

  def index(conn, _params) do
    next_meetup = SocialFeeds.get_next_meetup_event()
    render conn, "index.html", next_meetup: next_meetup
  end

  def mockup(conn, _params) do
    render conn, "mockup.html"
  end
end
