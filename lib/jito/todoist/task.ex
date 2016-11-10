defmodule Jito.Todoist.Task do
  @moduledoc "Representation of a Todoist task"
  defstruct [:project_id, :content, :priority, :due_date, :labels]
end
