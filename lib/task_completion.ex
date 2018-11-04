defmodule Ostinato.TaskCompletion do
  @moduledoc """
  Represents a single completion for a particular task.
  """
  use Ecto.Schema
  alias Ostinato.Task

  schema "task_completions" do
    belongs_to(:task, Task)
    field(:date, :date)
    timestamps()
  end
end
