defmodule Ristorante.Food do
  @moduledoc """
  The Food context.
  """

  import Ecto.Query, warn: false
  alias Ristorante.Repo

  alias Ristorante.Food.Category
  alias Ristorante.Food.Dish

  @doc """
  Creates a dish.

  ## Examples

      iex> create_dish(%{field: value})
      {:ok, %Dish{}}

      iex> create_dish(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dish(attrs \\ %{}) do
    %Dish{}
    |> Dish.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single category by some parameter list.

  Raises an `Ecto.MultipleResultsError` if more than
  one category satisfies the parameters.

  Returns `nil` if no category exists satisfying the
  parameters.

  ## Examples

      iex> get_category_by([param: value])
      %Category{}

      iex> get_category_by([param: duplicated_value])
      ** (Ecto.MultipleResultsError)

      iex> get_category_by([param: bad_value])
      :nil
  """
  def get_category_by(params) do
    Repo.get_by(Category, params)
  end

  @doc """
  Creates a category given a name.

  **This function is for seeds.exs only**. Do not
  use to insert arbitrary categories as it does not use
  the changeset.

  ## Examples

      iex> create_category!("Delicious")
      %Category{}
  """
  def create_catgeory!(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single dish by some parameter list.

  Raises an `Ecto.MultipleResultsError` if more than
  one dish satisfies the parameters.

  Returns `nil` if no dish exists satisfying the
  parameters.

  ## Examples

      iex> get_dish_by([param: value])
      %Category{}

      iex> get_dish_by([param: duplicated_value])
      ** (Ecto.MultipleResultsError)

      iex> get_dish_by([param: bad_value])
      :nil
  """
  def get_food_by(params) do
    Repo.get_by(Dish, params)
  end

  @doc """
  Gets the dishes belonging to a category with name `name`.

  Raises an error if the `name` does not belong to any
  categories.

  ## Examples

      iex> get_food_by_category("Desserts")
      ["Tiramisu", "Gelato"]

      iex> get_food_by_category(not_a_category)
      ** error
  """
  def get_food_by_category(name) do
    %Category{id: id} = get_category_by(name: name)

    query = from d in Dish, where: d.category_id == ^id

    Repo.all(query)
  end

  @doc """
  Gets the dishes with an id in `ids`.

  ## Examples

      iex> list_dishes_by_ids([1, 2, 5])
      [%Dish{id: 1}, %Dish{id: 2}, %Dish{id: 5}]

  """
  def list_dishes_by_ids(ids) do
    query = from d in Dish, where: d.id in ^ids

    Repo.all(query)
  end

  @doc """
  Gets all of the dishes in the db.

  ## Examples

      iex> list_dishes()
      [%Dish{}, ...]
  """
  def list_dishes() do
    Repo.all(Dish)
  end

  @doc """
  Gets all of the categories in the db.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]
  """
  def list_categories() do
    Repo.all(Category)
  end
end
