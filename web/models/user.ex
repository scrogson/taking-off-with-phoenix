defmodule Workshop.User do
  use Workshop.Web, :model

  alias Workshop.{Repo, User}

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @allowed_fields ~w(name email password password_confirmation)a

  def register_user(params \\ %{}) do
    %User{}
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password, message: "must match password")
    |> hash_password()
    |> Repo.insert()
  end

  def get_by_email_and_password(email, password) do
    user = Repo.get_by(User, email: email)
    if user && check_password(password, user.hashed_password) do
      {:ok, user}
    else
      Comeonin.Bcrypt.dummy_checkpw()
      {:error, "email or password incorrect"}
    end
  end

  defp hash_password(%{changes: %{password: password}, valid?: true} = changeset),
    do: put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
  defp hash_password(changeset), do: changeset

  def check_password(password, hashed) do
    Comeonin.Bcrypt.checkpw(password, hashed)
  end
end
