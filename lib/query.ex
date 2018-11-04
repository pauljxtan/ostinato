defmodule Ostinato.Query do
  @moduledoc """
  Provides light wrapper functions for database query logic.
  """
  import Ecto.Query
  alias Ostinato.{Repo, Task, TaskCompletion}

  @spec select_task(integer) :: struct() | :not_found
  def select_task(id) do
    case Repo.get(Task, id) do
      nil -> :not_found
      task -> task
    end
  end

  @spec select_completion_by_task_and_date(integer, NaiveDateTime.t()) ::
          struct() | :not_found
  def select_completion_by_task_and_date(task_id, date) do
    case Repo.get_by(TaskCompletion, task_id: task_id, date: date) do
      nil -> :not_found
      completion -> completion
    end
  end

  @spec select_titles() :: [struct()] | no_return()
  def select_titles(), do: Repo.all(from(t in Task, select: t.title))

  @spec select_tasks_with_completions() :: [struct()] | no_return()
  def select_tasks_with_completions(),
    do: Repo.all(from(t in Task, preload: [:task_completions]))

  @spec insert_task(String.t()) :: struct() | no_return()
  def insert_task(title), do: %Task{title: title} |> Repo.insert!()

  @spec insert_completion(integer, NaiveDateTime.t()) :: struct() | no_return()
  def insert_completion(task_id, date),
    do: %TaskCompletion{task_id: task_id, date: date} |> Repo.insert!()

  @spec delete_task(struct()) :: struct() | no_return()
  def delete_task(task), do: Repo.delete!(task)

  @spec delete_completion(struct()) :: struct() | no_return()
  def delete_completion(task_completion), do: Repo.delete!(task_completion)
end
