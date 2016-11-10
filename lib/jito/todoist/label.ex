defmodule Jito.Todoist.Label do
  defstruct [:todoist_id, :name, :is_deleted]

  def all do
    Jito.Todoist.Client.labels
    |> build
  end

  def for_name(name) do
    all
    |> Enum.find(fn(x) -> x.name == name end)
  end

  def for_issue(issue) do
    Jito.Jira.Issue.label_name(issue.key)
    |> for_name
  end

  def build(todoist_labels) do
    todoist_labels
    |> Enum.map(&build_struct(&1))
  end

  defp build_struct(todoist_label) do
    %__MODULE__{
      todoist_id: todoist_label["id"],
      name: todoist_label["name"],
      is_deleted: todoist_label["is_deleted"],
    }
  end
end
