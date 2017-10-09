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
  },

  _refreshAll(tweets) {
    this.tweets.empty()
    for(var tweet of tweets.slice(0,3)) {
      this.tweets.append(`<li>${tweet.text}<br><i>${tweet.timestamp}</i></li>`)
    }
    this.container.scrollTop(this.container[0].scrollHeight)
  }
}

export default TwitterTimeline
