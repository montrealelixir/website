defmodule MontrealElixirWeb.PageControllerTest do
  use MontrealElixirWeb.ConnCase

  describe "GET /" do
    test "shows About section", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "About Montreal Elixir"
    end

    test "shows the next meetup from Meetup.com", %{conn: conn} do
      conn = get conn, "/"
      resp = html_response(conn, 200)

      assert resp =~ "Next event"
      assert resp =~ "Wed June 14 at 6:30 PM"
      assert resp =~ "490 rue de la Gauchetiere Ouest"
    end
  end
end