defmodule Jito.MainChannel do
  use Phoenix.Channel

  def join("main_channel", _message, socket) do
    {:ok, socket}
  end

  def handle_in("sprints_for_project", board_id, socket) do
    broadcast!(socket, "sprints_for_project", %{sprints: Jito.Sprint.all(board_id)})
    {:noreply, socket}
  end

  def handle_in("upload_issue", payload, socket) do
    issue = Jito.Jira.Issue.from_payload(payload)
    Jito.Todoist.TaskCreator.call(issue)
    broadcast!(socket, "uploaded_issue", payload)
    {:noreply, socket}
  end
end
