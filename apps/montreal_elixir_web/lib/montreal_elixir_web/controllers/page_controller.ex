defmodule MontrealElixirWeb.PageController do
  use MontrealElixirWeb, :controller

  def index(conn, _params) do
    next_meetup = SocialFeeds.get_next_meetup_event()
    new_videos  = SocialFeeds.get_new_yt_videos()

    render conn, "index.html", next_meetup: next_meetup, new_videos: new_videos
  end

  def mockup(conn, _params) do
    render conn, "mockup.html"
  end
end
