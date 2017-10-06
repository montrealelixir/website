defmodule MontrealElixir.SocialFeeds.CacheTest do
  use ExUnit.Case, async: true

  alias MontrealElixir.SocialFeeds.Cache

  setup do
    {:ok, cache} = start_supervised Cache
    %{cache: cache}
  end

  describe "fetch/4" do
    test "returns the result of the default function", %{cache: cache} do
      default_function = fn -> 1 end

      assert Cache.fetch(cache, :my_key, default_function, %{}) == 1
    end
  end
end
