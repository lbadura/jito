defmodule Jito.Todoist.Client do
  import Todoist.Client
  alias Todoist.Command

  def projects do
    request = %Todoist.ReadRequest{resource_types: ["projects"]}
    Todoist.sync(request, api)["projects"]
  end

  def labels do
    request = %Todoist.ReadRequest{resource_types: ["labels"]}
    Todoist.sync(request, api)["labels"]
  end

  def add_item(task) do
    cmd = Command.build_from_opts("item_add", item_command_args(task))
    %Todoist.WriteRequest{commands: [cmd]}
    |> Todoist.sync(api)
  end

  defp api do
    {:ok, client} = Todoist.Client.new(System.get_env("TODOIST_API_TOKEN"))
    client
  end

  defp item_command_args(task) do
    %{
      project_id: task.project_id,
      content: task.content,
      priority: task.priority,
      labels: task.labels,
    }
    |> Keyword.new
  end
end
