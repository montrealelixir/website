defmodule Twitter.TimelineTest do
  use ExUnit.Case, async: false

  alias Twitter.{Timeline, Tweet}

  setup do
    adapter = Twitter.Adapter.Fake
    {:ok, pid} = adapter.start_link()

    on_exit fn -> assert_down(pid) end

    [adapter: adapter]
  end

  describe "initializing the timeline" do
    test "initializes the state with existing user's tweets", %{adapter: adapter} do
      adapter.put_tweets([
        %Tweet{text: ":tweet-2:"},
        %Tweet{text: ":tweet-1:"}
      ])

      {:ok, timeline} = Timeline.start_link(adapter: adapter)

      tweets = Timeline.tweets

      assert length(tweets) == 2
      first_tweet = List.first(tweets)
      assert %Tweet{text: ":tweet-2:"} = first_tweet

      on_exit fn -> assert_down(timeline) end
    end
  end

  describe "publishing tweets" do
    setup %{adapter: adapter} do
      topic = "test:timeline"
      PubSub.start_link()
      PubSub.subscribe(self(), topic)

      {:ok, timeline} = Timeline.start_link(adapter: adapter, topic: topic)
      on_exit fn -> assert_down(timeline) end

      :ok
    end

    test "publishes a new tweet", %{adapter: adapter} do
      tweet = %Tweet{text: ":text:"}
      adapter.stream_tweet(tweet)
      assert_receive {:new_tweet, ^tweet}
    end
  end

  # As suggested here:
  # https://elixirforum.com/t/how-to-stop-otp-processes-started-in-exunit-setup-callback/3794/5
  defp assert_down(pid) do
    ref = Process.monitor(pid)
    assert_receive {:DOWN, ^ref, _, _, _}
  end
end
