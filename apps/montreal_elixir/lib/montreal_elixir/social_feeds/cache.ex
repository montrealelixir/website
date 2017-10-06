defmodule MontrealElixir.SocialFeeds.Cache do
  def fetch(_key, default_value_function, _opts) do
    default_value_function.()
  end
end
