defmodule MontrealElixirWeb.PageView do
  use MontrealElixirWeb, :view

  import MontrealElixirWeb.DateTimeHelpers

  defp human_date(date_time) do
    Timex.format!(date_time, "{D} {Mshort} {YYYY}")
  end
end
