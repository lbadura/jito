defmodule Jito.Todoist.TaskCreator do
  def call(issue) do
    %Jito.Todoist.Task{content: content(issue), labels: [label_id(issue)], priority: priority(issue)}
    |> Jito.Todoist.Client.add_item
  end

  defp content(issue) do
    "[#{issue.key}] - #{issue.summary}"
  end

  defp label_id(issue) do
    Jito.Todoist.Label.for_issue(issue).todoist_id
  end

  defp priority(issue) do
    case issue.label do
      "GAR" -> 2
      "GR" -> 4
      "IR" -> 4
      _ -> 1
    end
  end
end
