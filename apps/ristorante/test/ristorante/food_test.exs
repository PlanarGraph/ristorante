defmodule Ristorante.FoodTest do
  use Ristorante.DataCase, async: true

  alias Ristorante.Food
  alias Ristorante.Food.Category
  alias Ristorante.Food.Dish

  describe "create_category/1" do
    @valid_attrs %{
      name: "Category"
    }

    @invalid_attrs %{}

    test "valid data inserts category" do
      assert {:ok, %Category{id: id} = category} = Food.create_category(@valid_attrs)
      assert category.name == "Category"
    end

    test "invalid data does not insert" do
      assert {:error, _reason} = Food.create_category(@invalid_attrs)
      assert Food.list_categories() == []
    end
  end

  describe "create_dish/1" do
    @valid_attrs %{
      name: "Dish",
      price: 13.50
    }

    @invalid_attrs %{}

    test "valid data inserts dish" do
      assert {:ok, %Dish{id: id} = dish} = Food.create_dish(@valid_attrs)
      assert dish.name == "Dish"
      assert dish.price == 13.50
    end

    test "invalid data does not insert" do
      assert {:error, _reason} = Food.create_dish(@invalid_attrs)
      assert Food.list_dishes() == []
    end
  end

  describe "dish image_path" do
    test "image_path is correct" do
      assert {:ok, %Category{id: id}} = Food.create_category(%{name: "Italian"})
      attrs = %{name: "Pizza Pie", price: 15.50, category_id: id}
      assert {:ok, dish} = Food.create_dish(attrs)
      assert dish.image_path == "/images/Italian/pizzapie.jpg"
    end
  end
end
