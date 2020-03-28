defmodule Ristorante.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :address, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_length(:username, min: 1, max: 20)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
  end

  # Changeset for registering users.
  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:first_name, :last_name, :address, :password])
    |> validate_required([:first_name, :last_name, :address, :password])
    |> validate_length(:password, min: 6, max: 64)
    |> put_pass_hash()
  end

  # If the changeset is valid, add the password hash.
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
