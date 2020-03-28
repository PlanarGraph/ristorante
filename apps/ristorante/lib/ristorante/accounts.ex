defmodule Ristorante.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ristorante.Repo

  alias Ristorante.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Gets a single user.

  Returns `nil` if the user does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Gets a single user with some parameter list.

  Returns `nil` if no user was found.

  Raises `Ecto.MultipleResultsError` error if more than one user found.

  ## Examples

      iex> get_user_by(valid_params)
      %User{}

      iex> get_user_by(invalid_params)
      nil

      iex> get_user_by(ambiguous_params)
      ** (Ecto.MultipleResultsError)

  """
  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  @doc """
  Creates a user with the registration changeset.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs \\ {}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes with
  the registration changeset.

  ## Examples

      iex> change_registration(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_registration(%User{} = user) do
    User.registration_changeset(user, %{})
  end

  @doc """
  Authenticates the user with `username` using the `given_pass`.

  If the user is not found, a `:not_found` error is returned.

  If the `given_pass` does not matched the hashed password,
  an `:unauthorized` error is returned.

  Otherwise, the validation is successful and the user is returned.

  ## Examples

      iex> authenticate_by_uname_and_pass(valid_uname, valid_pass)
      {:ok, %User{}}

      iex> authenticate_by_uname_and_pass(invalid_uname, valid_pass)
      {:error, :not_found}

      iex> authenticate_by_uname_and_pass(valid_name, invalid_pass)
      {:error, :unauthorized}

  """
  def authenticate_by_uname_and_pass(username, given_pass) do
    user = get_user_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
