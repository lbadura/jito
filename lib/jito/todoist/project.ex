defmodule Jito.Todoist.Project do
  defstruct [:todoist_id, :name, :is_deleted, :parent_id, :shared]

  def for_sprint(board_id, sprint_id) do
    %{"contents" => %{"issuesNotCompletedInCurrentSprint" => issues_not_completed, "completedIssues" => issues_completed}} = Jira.SprintReport.get(board_id, sprint_id)
    List.flatten(build(issues_completed, true), build(issues_not_completed, false))
  end

  def build_struct(todoist_project) do
    %__MODULE__{
      todoist_id: todoist_project["id"],
      name: todoist_project["name"],
      is_deleted: todoist_project["is_deleted"],
      parent_id: todoist_project["parent_id"],
      shared: todoist_project["shared"]
    }
  end

  def build(todoist_projects, completed \\ false) do
    todoist_projects
    |> Enum.map(&build_struct(&1))
  end

  def all do
    Jito.Todoist.Client.projects
    |> build
  end

  def for_name(name) do
    all
    |> Enum.find(fn(x) -> x.name == name end)
  end
end
