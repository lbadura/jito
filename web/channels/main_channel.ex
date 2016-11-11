defmodule Jito.MainChannel do
  use Phoenix.Channel
  alias Jito.Jira.Sprint
  alias Jito.Jira.Issue
  alias Jito.Todoist.TaskCreator

  def join("main_channel", _message, socket) do
    {:ok, socket}
  end

  def handle_in("sprints_for_project", board_id, socket) do
    broadcast!(socket, "sprints_for_project", %{sprints: Sprint.all(board_id)})
    {:noreply, socket}
  end

  def handle_in("upload_issue", payload, socket) do
    issue = Issue.from_payload(payload)
    TaskCreator.call(issue)
    broadcast!(socket, "uploaded_issue", payload)
    {:noreply, socket}
  end
end
