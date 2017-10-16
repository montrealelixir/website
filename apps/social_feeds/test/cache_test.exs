defmodule SocialFeeds.CacheTest do
  use ExUnit.Case

  alias SocialFeeds.Cache

  describe "clear/0" do
    test "clears keys from cache" do
      Cache.fetch(:cached_key, fn -> :cached_val end, %{cache_ttl_in_msec: 1_000_000})

      Cache.clear()

      assert Cache.fetch(:new_key, fn -> :new_val end, %{}) == :new_val
    end
  end

  describe "fetch/3" do
    setup do
      Cache.clear()
    end

    test "returns the result of the default function" do
      default_function = fn -> 1 end

      assert Cache.fetch(:new_key, default_function, %{}) == 1
    end

    test "returns the cached result if available" do
      Cache.fetch(:cached_key, fn -> 2 end, %{})

      assert Cache.fetch(:cached_key, fn -> :dont_return_this end, %{}) == 2
    end

    test "returns newly fetched value for expired key" do
      Cache.fetch(:expired_key, fn -> 3 end, %{cache_ttl_in_msec: 0})

      assert Cache.fetch(:expired_key, fn -> :return_this end, %{}) == :return_this
    end
  end
end
