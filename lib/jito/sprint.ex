defmodule Jito.Sprint do
  defstruct [:jira_id, :name, :state]

  import Jira.Sprint

  def all(board_id) do
    Jira.Sprint.all(board_id)
    |> Enum.map(&build_struct/1)
    |> Enum.sort_by(fn(x) -> x.jira_id end)
    |> Enum.reverse
  end


  def build_struct(json_sprint) do
    %__MODULE__{jira_id: json_sprint["id"], name: json_sprint["name"], state: json_sprint["state"]}
  end
end
