import "../css/app.css";

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
import socket from "./socket"

import TwitterTimeline from "./twitter_timeline"

TwitterTimeline.init(socket, "#tweets-container")
