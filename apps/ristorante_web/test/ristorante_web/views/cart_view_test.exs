defmodule RistoranteWeb.CartViewTest do
  use RistoranteWeb.ConnCase

  alias RistoranteWeb.CartView

  setup do
    category = category_fixture()
    {:ok, category_id: category.id}
  end

  test "formats correctly", %{category_id: id} do
    dish = dish_fixture(price: 25.52, category_id: id)
    assert CartView.format_price(dish.price) == "$25.52"
  end

  test "adds two decimal places", %{category_id: id} do
    dish = dish_fixture(price: 10.0, category_id: id)
    assert CartView.format_price(dish.price) == "$10.00"
  end

  test "rounds to two decimals", %{category_id: id} do
    dish = dish_fixture(price: 300.5674, category_id: id)
    assert CartView.format_price(dish.price) == "$300.57"
  end
end
