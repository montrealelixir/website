defmodule MontrealElixir.SocialFeeds.CacheTest do
  use ExUnit.Case, async: true

  alias MontrealElixir.SocialFeeds.Cache

  describe "fetch/3" do
    test "returns the result of the default function" do
      default_function = fn -> 1 end

      assert Cache.fetch(:new_key, default_function, %{}) == 1
    end

    test "returns the cached result if available" do
      Cache.fetch(:cached_key, fn -> 2 end, %{})

      assert Cache.fetch(:cached_key, fn -> :dont_return_this end, %{}) == 2
    end
  end
end
