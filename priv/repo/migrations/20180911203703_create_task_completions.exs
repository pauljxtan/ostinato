defmodule Ostinato.Repo.Migrations.CreateTaskCompletions do
  use Ecto.Migration

  def change do
    create table(:task_completions) do
      add(:date, :date)
      add(:task_id, references(:tasks, on_delete: :delete_all))
      timestamps()
    end
  end
end
