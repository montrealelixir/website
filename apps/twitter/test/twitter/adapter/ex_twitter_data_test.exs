defmodule Twitter.Adapter.ExTwitter.DataTest do
  use ExUnit.Case, async: false

  alias Twitter.{Adapter, Tweet}

  test "converts a ExTwitter.Model.Tweet to Tweet" do
    ex_twitter_tweet = %ExTwitter.Model.Tweet{id: ":id:", text: ":text:", created_at: ":time:"}

    tweet = Adapter.ExTwitter.Data.convert(ex_twitter_tweet)

    assert tweet == %Tweet{id: ":id:", text: ":text:", timestamp: ":time:"}
  end
end
