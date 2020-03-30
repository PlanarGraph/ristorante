defmodule Ristorante.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Ristorante.Repo

  alias Ristorante.Transactions.Purchase

  @doc """
  Returns the list of purchases.

  ## Examples

      iex> list_purchases()
      [%Purchase{}, ...]

  """
  def list_purchases do
    Repo.all(Purchase)
  end

  @doc """
  Gets a single purchase.

  Raises `Ecto.NoResultsError` if the Purchase does not exist.

  ## Examples

      iex> get_purchase!(123)
      %Purchase{}

      iex> get_purchase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchase!(id), do: Repo.get!(Purchase, id)

  @doc """
  Creates a purchase.

  ## Examples

      iex> create_purchase(%{field: value})
      {:ok, %Purchase{}}

      iex> create_purchase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchase(attrs \\ %{}) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a purchase.

  ## Examples

      iex> update_purchase(purchase, %{field: new_value})
      {:ok, %Purchase{}}

      iex> update_purchase(purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchase(%Purchase{} = purchase, attrs) do
    purchase
    |> Purchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a purchase.

  ## Examples

      iex> delete_purchase(purchase)
      {:ok, %Purchase{}}

      iex> delete_purchase(purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchase(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase changes.

  ## Examples

      iex> change_purchase(purchase)
      %Ecto.Changeset{source: %Purchase{}}

  """
  def change_purchase(%Purchase{} = purchase) do
    Purchase.changeset(purchase, %{})
  end

  @doc """
  Gets a single purchase by some parameter list.

  Raises an `Ecto.MultipleResultsError` if more than
  one purchase satisfies the parameters.

  Returns `nil` if no purchase exists satisfying the
  parameters.

  ## Examples

      iex> get_purchase_by([param: value])
      %purchase{}

      iex> get_purchase_by([param: duplicated_value])
      ** (Ecto.MultipleResultsError)

      iex> get_purchase_by([param: bad_value])
      :nil
  """
  def get_purchase_by(params), do: Repo.get_by(Purchase, params)
end
