defmodule Ristorante.Food.Dish do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dishes" do
    field :name, :string
    field :price, :float
    field :description, :string

    belongs_to :category, Ristorante.Food.Category
    timestamps()
  end

  @doc false
  def changeset(dish, attrs) do
    dish
    |> cast(attrs, [:name, :price, :category_id, :description])
    |> validate_required([:name, :price])
    |> assoc_constraint(:category)
    |> unique_constraint(:name)
  end
end
