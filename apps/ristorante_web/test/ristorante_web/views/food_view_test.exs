defmodule RistoranteWeb.FoodViewTest do
  use RistoranteWeb.ConnCase

  alias RistoranteWeb.FoodView

  describe "format_price/1" do
    setup do
      category = category_fixture()
      {:ok, category_id: category.id}
    end

    test "formats correctly", %{category_id: id} do
      dish = dish_fixture(price: 25.52, category_id: id)
      assert FoodView.format_price(dish) == "$25.52"
    end

    test "adds two decimal places", %{category_id: id} do
      dish = dish_fixture(price: 10.0, category_id: id)
      assert FoodView.format_price(dish) == "$10.00"
    end

    test "rounds to two decimals", %{category_id: id} do
      dish = dish_fixture(price: 300.5674, category_id: id)
      assert FoodView.format_price(dish) == "$300.57"
    end
  end
end
