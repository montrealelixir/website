defmodule MontrealElixirWeb.LayoutView do
  use MontrealElixirWeb, :view

  def show_flash(conn) do
    conn
    |> get_flash()
    |> display_flash()
  end

  defp display_flash(%{"info" => msg}) do
    ~E"<div class='alert alert-info'><%= msg %></div>"
  end

  defp display_flash(%{"error" => msg}) do
    ~E"<div class='alert alert-danger'><%= msg %></div>"
  end

  defp display_flash(_), do: nil
end
