defmodule Ostinato.Task do
  @moduledoc """
  Represents a single task.
  """
  use Ecto.Schema
  alias Ostinato.TaskCompletion

  schema "tasks" do
    has_many(:task_completions, TaskCompletion)
    field(:title, :string)
    timestamps()
  end

  @spec encodable(struct()) :: map()
  def encodable(%Ostinato.Task{
        id: id,
        title: title,
        task_completions: task_completions
      }) do
    completions = Enum.map(task_completions, fn tc -> tc.date end)
    %{:id => id, :title => title, :completions => completions}
  end
end
