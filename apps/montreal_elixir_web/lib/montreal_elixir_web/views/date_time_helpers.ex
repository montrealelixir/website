defmodule MontrealElixirWeb.DateTimeHelpers do
  def format_montreal_time(utc_datetime) do
    utc_datetime
    |> Timex.to_datetime("America/Montreal")
    |> Timex.format!("{WDshort} {Mfull} {D} at {h12}:{m} {AM}")
  end
end
