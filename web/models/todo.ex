defmodule PhoenixTodosApi.Todo do
  use PhoenixTodosApi.Web, :model

  schema "todos" do
    field :title, :string
    field :is_completed, :boolean, default: false

    timestamps
  end

  @required_fields ~w(title is_completed)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
