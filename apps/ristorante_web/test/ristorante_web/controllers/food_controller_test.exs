defmodule RistoranteWeb.FoodControllerTest do
  use RistoranteWeb.ConnCase

  describe "show food" do
    setup %{conn: conn} do
      category = category_fixture(name: "Italian")
      dish = dish_fixture(name: "Spaghetti", category_id: category.id)

      {:ok, conn: conn, category: category, dish: dish}
    end

    test "renders the dishes in a category", %{conn: conn, category: category} do
      conn = get(conn, Routes.food_path(conn, :show, category.name))
      assert html_response(conn, 200) =~ "Spaghetti"
    end
  end
end
