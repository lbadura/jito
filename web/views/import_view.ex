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
end
