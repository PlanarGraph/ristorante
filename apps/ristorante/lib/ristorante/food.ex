defmodule Ristorante.Food do
  @moduledoc """
  The Food context.
  """

  import Ecto.Query, warn: false
  alias Ristorante.Repo

  alias Ristorante.Food.Category
  alias Ristorante.Food.Dish

  def create_dish(attrs \\ %{}) do
    %Dish{}
    |> Dish.changeset(attrs)
    |> Repo.insert()
  end

  def get_category_by(params) do
    Repo.get_by(Category, params)
  end

  def create_catgeory!(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end

  def get_food_by(params) do
    Repo.get_by(Dish, params)
  end

  # Gets the food belonging to a category.
  def get_food_by_category(name) do
    %Category{id: id} = get_category_by(name: name)

    query = from d in Dish, where: d.category_id == ^id

    Repo.all(query)
  end

  def list_dishes_by_ids(ids) do
    query = from d in Dish, where: d.id in ^ids

    Repo.all(query)
  end
end
