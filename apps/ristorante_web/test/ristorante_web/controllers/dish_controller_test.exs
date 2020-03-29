defmodule RistoranteWeb.DishControllerTest do
  use RistoranteWeb.ConnCase

  describe "show dish" do
    setup %{conn: conn} do
      category = category_fixture(name: "Italian")
      dish = dish_fixture(name: "Cannoli", category_id: category.id)

      {:ok, conn: conn, dish: dish}
    end

    test "renders dish", %{conn: conn, dish: dish} do
      conn = get(conn, Routes.dish_path(conn, :show, dish))
      assert html_response(conn, 200) =~ "Cannoli"
    end
  end
end
