let TwitterTimeline = {
  init(socket, tweets_container) {
    // Now that you are connected, you can join channels with a topic:
    this.channel = socket.channel("twitter_timeline", {})
    this.container = $(tweets_container)
    this.tweets = $(tweets_container).find(".tweets")

    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    this.channel.onError(e => console.log("something went wrong", e))
    this.channel.onClose(e => console.log("channel closed", e))

    this.channel.on("updated_list", msg => {
      this._refreshAll(msg.tweets)
    })

    this.channel.on("new_tweet", tweet => {
      this._newTweet(tweet)
    })
  },

  _refreshAll(tweetsList) {
    this.tweets.empty()
    for(var tweet of tweetsList.slice(0,3)) {
      var text = tweet.text.autoLink({target: "_blank"})
      this.tweets.append(`<li>${text}<br><i>${tweet.timestamp}</i></li>`)
    }
    this.container.scrollTop(this.container[0].scrollHeight)
  },

  _newTweet(tweet) {
    var text = tweet.text.autoLink({target: "_blank"})
    this.tweets.prepend(`<li>${text}<br><i>${tweet.timestamp}</i></li>`)
    this.container.scrollTop(this.container[0].scrollHeight)
  }
}

export default TwitterTimeline
