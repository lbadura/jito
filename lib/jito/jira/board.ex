defmodule Jito.Jira.Board do
  defstruct [:jira_id, :name]

  import Jira.Board

  def all do
    Jira.Board.all
    |> Enum.map(&build_struct/1)
    |> Enum.sort_by(fn(x) -> x.name end)
  end

  def ga_boards do
    Jito.Jira.Board.all
    |> Enum.filter(&ga_board?/1)
  end

  def by_name(name) do
    Jito.Jira.Board.all |> Enum.filter(fn(x) -> x.name == name end)
  end

  def build_struct(json_board) do
    %__MODULE__{jira_id: json_board["id"], name: json_board["name"]}
  end

  defp ga_board?(board) do
    ["Growth Automation", "Growth Automation Requests", "IR"]
    |> Enum.member?(board.name)
  end
end
