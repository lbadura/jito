// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

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

let channel = socket.channel("main_channel", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("uploaded_issue", payload => {
  console.log('Uploaded: ' + payload["summary"])
})

channel.on("sprints_for_project", payload => {
  $("#sprints").html("")
  for (const sprint of payload["sprints"]) {
    $("#sprints").append($("<option></option>").text(sprint["name"]).data('id', sprint["jira_id"]))
  }
})

$(document).ready(function() {
  $('#projects').on('change', function(ev) {
    channel.push("sprints_for_project", $('#projects option:selected').data("id"))
  })

  $('.issue-btn').on('click', function(ev) {
    var target = $(ev.target)
    var issue_id = target.data('id')
    var key = target.data('key')
    var summary = target.data('summary')
    channel.push("upload_issue", {issue_id: issue_id, key: key, summary: summary})
  })

  $("#issue-load").on("click", function(ev) {
    var board_id = $("#projects option:selected").data("id")
    var sprint_id = $("#sprints option:selected").data("id")
    window.location.search = "?board_id=" + board_id + "&sprint_id=" + sprint_id
  })
})
