defmodule Support.User do
  use Support.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :issues, Support.Issue

    timestamps
  end

  @required_fields ~w(name email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password, "must match password")
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    if password = get_change(changeset, :password) do
      put_change(changeset, :encrypted_password, hash_password(password))
    else
      changeset
    end
  end

  defp hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def check_password(password, crypted) do
    Comeonin.Bcrypt.checkpw(password, crypted)
  end
end
