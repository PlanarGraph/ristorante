defmodule Ristorante.Food.Dish do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dishes" do
    field :name, :string
    field :price, :float
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(dish, attrs) do
    dish
    |> cast(attrs, [:name, :price])
    |> validate_required([:name, :price])
  end
end
