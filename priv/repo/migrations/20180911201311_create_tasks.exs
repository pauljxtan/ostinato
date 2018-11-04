defmodule Ostinato.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:title, :string)
      timestamps()
    end
  end
end
