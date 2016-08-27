defmodule Jito.ImportController do
  use Jito.Web, :controller

  def index(conn, %{"board_id" => board_id, "sprint_id" => sprint_id}) do
    {board_id, _} = Integer.parse(board_id)
    {sprint_id, _} = Integer.parse(sprint_id)

    sprints = Jito.Sprint.all(board_id)
    issues = Jito.Issue.for_sprint(board_id, sprint_id)
    render conn, "index.html", boards: Jito.Board.ga_boards, sprints: sprints, issues: issues, board_id: board_id, sprint_id: sprint_id
  end

  def index(conn, %{"board_id" => board_id}) do
    {board_id, _} = Integer.parse(board_id)
    sprints = Jito.Sprint.all(board_id)

    render conn, "index.html", boards: Jito.Board.ga_boards, sprints: sprints, issues: [], board_id: board_id, sprint_id: nil
  end

  def index(conn, %{}) do
    render conn, "index.html", boards: Jito.Board.ga_boards, sprints: [], issues: [], board_id: nil, sprint_id: nil
  end
end
