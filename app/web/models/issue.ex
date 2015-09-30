defmodule Support.Issue do
  use Support.Web, :model

  schema "issues" do
    field :title, :string
    field :description, :string
    field :closed, :boolean, default: false
    field :closed_at, Ecto.DateTime
    belongs_to :user, Support.User

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, context, params \\ :empty)
  def changeset(model, :insert, params) do
    model
    |> cast(params, ~w(title description), ~w())
  end

  def changeset(model, :update, params) do
    model
    |> cast(params, ~w(), ~w(title description closed))
    |> close()
  end

  defp close(changeset) do
    case get_change(changeset, :closed) do
      nil   -> changeset
      true  -> put_change(changeset, :closed_at, Ecto.DateTime.utc)
      false -> put_change(changeset, :closed_at, nil)
    end
  end
end
