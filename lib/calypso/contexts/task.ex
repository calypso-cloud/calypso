defmodule Calypso.Contexts.Task do
  import Ecto.Query, warn: false

  alias Calypso.Repo
  alias Calypso.Models.Task

  @spec get(id :: integer()) :: Task.t() | nil
  def get(id) do
    Repo.get(Task, id)
  end

  @spec get_by_date(date :: %DateTime{}) :: [Task.t()]
  def get_by_date(date) do
    from(task in Task,
      order_by: task.start_date
    )
    |> Repo.all()
    |> Enum.filter(&(Date.compare(&1.start_date, date) == :eq))
  end

  @spec create(task :: Task.t(), params :: map()) ::
          {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def create(task, params) do
    task
    |> Task.changeset(params)
    |> Repo.insert()
  end

  @spec update(task :: Task.t(), params :: map()) ::
          {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def update(task, params) do
    task
    |> Task.changeset(params)
    |> Repo.update()
  end

  @spec delete(task :: Task.t()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def delete(task) do
    task
    |> Repo.delete()
  end
end
