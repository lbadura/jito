defmodule Jito.Jira.Board do
  defstruct [:jira_id, :name]

  import Jira.Board

  def all do
    Jira.Board.all
    |> Enum.map(&build_struct/1)
    |> Enum.filter(&applicable?/1)
    |> Enum.sort(&(&1.name <= &2.name))
  end

  def by_name(name) do
    Jito.Jira.Board.all |> Enum.filter(fn(x) -> x.name == name end)
  end

  def build_struct(json_board) do
    %__MODULE__{jira_id: json_board["id"], name: json_board["name"]}
  end

  defp applicable?(board) do
    Application.get_env(:jito, __MODULE__)[:boards]
    |> Enum.member?(board.name)
  end
end
