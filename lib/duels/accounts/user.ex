defmodule Duels.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 3, max: 20)
    |> validate_format(:username, ~r/^[a-zA-Z][a-zA-Z0-9_\- ]+$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:username)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end

  def get_by_username(username) do
    case Repo.get_by(User, username: username) do
      nil ->
        {:error, :not_found}
      user ->
        {:ok, user}
    end
  end
end
