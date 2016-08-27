defmodule Jito.Issue do
  defstruct [:jira_id, :assignee, :assignee_name, :key, :status, :summary, :epic, :epic_name, :avatar_url, :completed]

  import Jira.SprintReport

  def for_sprint(board_id, sprint_id) do
    %{"contents" => %{"issuesNotCompletedInCurrentSprint" => issues_not_completed, "completedIssues" => issues_completed}} = Jira.SprintReport.get(board_id, sprint_id)
    List.flatten(build(issues_completed, true), build(issues_not_completed, false))
  end

  def build_struct(json_issue, completed \\ false) do
    %__MODULE__{
      jira_id: json_issue["id"], assignee: json_issue["assignee"], assignee_name: json_issue["assigneeName"],
      key: json_issue["key"], status: json_issue["statusName"], summary: json_issue["summary"], epic: json_issue["epic"],
      epic_name: json_issue["epicField"]["text"], avatar_url: json_issue["avatarUrl"], completed: completed
    }
  end

  def build(issues, completed) do
    issues
    |> Enum.map(&build_struct(&1, completed))
  end
end
