defmodule MontrealElixirWeb.PageControllerTest do
  use MontrealElixirWeb.ConnCase

  describe "GET /" do
    setup do
      SocialFeeds.Cache.clear()
    end

    @tag :capture_log
    test "shows About section", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "About Montreal Elixir"
    end

    @tag :capture_log
    test "shows the next meetup from Meetup.com", %{conn: conn} do
      conn = get conn, "/"
      resp = html_response(conn, 200)

      assert resp =~ "Next event" || resp =~ "Most recent event"
      assert resp =~ "Wed October 11 at 6:30 PM"
      assert resp =~ "490 rue de la Gauchetiere Ouest"
    end
  end
end
