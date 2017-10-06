defmodule MontrealElixir.SocialFeeds.CacheTest do
  use ExUnit.Case, async: true

  alias MontrealElixir.SocialFeeds.Cache

  describe "fetch/4" do
    test "returns the result of the default function" do
      default_function = fn -> 1 end

      assert Cache.fetch(:my_key, default_function, %{}) == 1
    end
  end
end
