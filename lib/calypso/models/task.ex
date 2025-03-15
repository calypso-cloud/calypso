defmodule Calypso.Models.Task do
  use Ecto.Schema

  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  schema "tasks" do
    field :title, :string
    field :completed, :boolean
    field :description, :string
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    field :priority, :string
    field :categories, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs \\ %{}) do
    task
    |> cast(attrs, permitted_fields())
    |> validate_required(required_fields())
  end

  def apply_changeset(task, attrs \\ %{}) do
    task
    |> cast(attrs, permitted_fields())
    |> validate_required(required_fields())
    |> validate_length(:title, min: 1)
  end

  defp permitted_fields() do
    [
      :title,
      :completed,
      :description,
      :start_date,
      :end_date,
      :priority,
      :categories
    ]
  end

  defp required_fields() do
    [:title, :completed, :start_date, :end_date, :categories]
  end
end
