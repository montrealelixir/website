defmodule MontrealElixirWeb.PageViewTest do
  use MontrealElixirWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html if no next_meetup", %{conn: conn} do
    content =
      render_to_string(
        MontrealElixirWeb.PageView,
        "index.html",
        conn: conn,
        next_meetup: nil,
        new_videos: []
      )

    assert String.contains?(content, "Montreal Elixir")
    refute String.contains?(content, "Next event")
  end
end
