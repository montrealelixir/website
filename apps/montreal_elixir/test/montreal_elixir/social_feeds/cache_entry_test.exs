defmodule MontrealElixir.SocialFeeds.CacheEntryTest do
  use ExUnit.Case, async: true

  alias MontrealElixir.SocialFeeds.Cache.Entry

  describe "build/2" do
    test "returns Entry with value and expiry time" do
      expiry_period_in_msec = 60_000
      entry = Entry.build(1, expiry_period_in_msec)

      assert entry.value == 1
      assert_in_delta entry.expires_at, :os.system_time(:millisecond) + expiry_period_in_msec, 1_000
    end
  end

  describe "expired/1" do
    test "returns true iff entry is past its expiry time" do
      assert Entry.expired?(%Entry{value: nil, expires_at: :os.system_time(:millisecond) - 1_000})
      refute Entry.expired?(%Entry{value: nil, expires_at: :os.system_time(:millisecond) + 1_000})
    end
  end
end
