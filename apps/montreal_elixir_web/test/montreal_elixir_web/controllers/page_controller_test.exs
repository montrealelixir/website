defmodule MontrealElixirWeb.PageControllerTest do
  use MontrealElixirWeb.ConnCase

  describe "GET /" do
    test "shows About section", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "About Montreal Elixir"
    end
  end
end
