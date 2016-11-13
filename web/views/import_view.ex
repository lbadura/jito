defmodule Jito.ImportView do
  use Jito.Web, :view

  def selected(resource, resource_id) do
    if resource.jira_id == resource_id do
      "selected=selected"
    else
      ""
    end
  end

  def avatar(issue) do
    "<img src=\"#{issue.avatar_url}\" alt=\"#{issue.assignee_name}\"/>"
  end

  def issue_css_class(issue) do
    issue.status
    |> String.downcase
    |> String.replace(" ", "-")
    |> String.replace("!", "")
  end
end
