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
end
