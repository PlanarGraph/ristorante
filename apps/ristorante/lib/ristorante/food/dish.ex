defmodule Ristorante.Food.Dish do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dishes" do
    field :name, :string
    field :price, :float
    field :description, :string
    field :image_path, :string

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
    |> add_image_path()
  end

  defp add_image_path(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name, category_id: cid}} ->
        category = Ristorante.Food.get_category_by(id: cid)
        put_change(changeset, :image_path, gen_image_path(name, category))

      _ ->
        IO.puts("here")
        changeset
    end
  end

  defp gen_image_path(name, category) do
    name_format =
      name
      |> String.downcase()
      |> String.split(" ")
      |> Enum.join()

    "/images/" <> category.name <> "/" <> name_format <> ".jpg"
  end
end
