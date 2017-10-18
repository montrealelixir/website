defmodule MontrealElixirWeb.DateTimeHelpers do
  @moduledoc """
  Helper functions to format date/time in views.

  Depends on `timex` package.
  """

  @doc """
  Returns the date/time formatted for Montreal (EST/EDT) time zone.

  Automatically deals with switching between EST and EDT.

  ## Examples

      iex> {:ok, d, 0} = DateTime.from_iso8601("2017-01-02 15:16:17Z") ; format_montreal_time(d)
      "Mon January 2 at 10:16 AM"

  """
  def format_montreal_time(utc_datetime) do
    utc_datetime
    |> Timex.to_datetime("America/Montreal")
    |> Timex.format!("{WDshort} {Mfull} {D} at {h12}:{m} {AM}")
  end

  @doc """
  Places "Next Event" in the header if the datetime is in the future from now.
  Otherwise places "Most recent event" in the header.

  ## Examples

      iex> {:ok, d, 0} = DateTime.from_iso8601("2017-01-02 15:16:17Z"); next_or_most_recent_event(d)
      "Most recent event"
      iex> {:ok, d, 0} = DateTime.from_iso8601("2030-05-07 15:16:17Z"); next_or_most_recent_event(d)
      "Next event"
  """
  def next_or_most_recent_event(utc_datetime) do
    if Timex.before?(utc_datetime, Timex.now) do
      "Most recent event"
    else
      "Next event"
    end
  end

end
