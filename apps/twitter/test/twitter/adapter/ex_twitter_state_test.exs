defmodule Twitter.Adapter.ExTwitter.StateTest do
  use ExUnit.Case, async: false

  alias Twitter.{Adapter, Tweet, TweetDeletion}

  test "converts a ExTwitter.Model.Tweet to Tweet" do
    ex_twitter_tweet = %ExTwitter.Model.Tweet{id: ":id:", text: ":text:", created_at: ":time:"}

    tweet = Adapter.ExTwitter.State.convert(ex_twitter_tweet)

    assert tweet == %Tweet{id: ":id:", text: ":text:", timestamp: ":time:"}
  end

  test "converts a ExTwitter.Model.DeletedTweet to TweetDeletion" do
    ex_twitter_deleted_tweet = %ExTwitter.Model.DeletedTweet{status: %{id: ":id:"}}

    tweet_deletion = Adapter.ExTwitter.State.convert(ex_twitter_deleted_tweet)

    assert tweet_deletion == %TweetDeletion{tweet_id: ":id:"}
  end

  test "filters a stream of tweets" do
    unwanted_messages = [
      %ExTwitter.Model.User{},
      {:friends, %{friends: [343, 22, 344]}}
    ]
    wanted_message = [
      %ExTwitter.Model.Tweet{},
      %ExTwitter.Model.DeletedTweet{status: %{id: ":id:"}},
    ]
    stream = Stream.cycle(unwanted_messages ++ wanted_message)

    tweets_stream = Adapter.ExTwitter.State.filter_stream(stream)

    [first, second] = Enum.take(tweets_stream, 2)
    assert %Tweet{} = first
    assert %TweetDeletion{} = second
  end
end
