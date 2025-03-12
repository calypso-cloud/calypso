defmodule Calypso.Repo.Migrations.AddTasksTable do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :completed, :boolean, default: false, null: false
      add :description, :string
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime
      add :priority, :string
      add :categories, {:array, :string}

      timestamps(type: :utc_datetime)
    end
  end
end
