defmodule Ristorante.CartControllerTest do
  use RistoranteWeb.ConnCase

  describe "cart index" do
    setup %{conn: conn} do
      category = category_fixture(name: "Italian")
      dish = dish_fixture(name: "Sauce", category_id: category.id)
      cart = %{num_items: 1, items: %{dish.id => 1}}

      conn = assign(conn, :cart, cart)

      {:ok, conn: conn}
    end

    test "renders cart", %{conn: conn} do
      conn = get(conn, Routes.cart_path(conn, :index))

      assert html_response(conn, 200) =~ "Your Cart"
    end

    test "renders with items in cart", %{conn: conn} do
      conn = get(conn, Routes.cart_path(conn, :index))

      assert html_response(conn, 200) =~ "Sauce"
    end
  end

  describe "cart update" do
    setup %{conn: conn} do
      category = category_fixture(name: "Italian")
      dish = dish_fixture(name: "Sauce", category_id: category.id)
      cart = %{num_items: 1, items: %{dish.id => 1}}

      conn = assign(conn, :cart, cart)

      {:ok, conn: conn, dish_id: "#{dish.id}"}
    end

    test "redirects to cart index", %{conn: conn} do
      conn = put(conn, Routes.cart_path(conn, :update, "change"), cart_params: %{"1" => "1"})

      assert redirected_to(conn) == Routes.cart_path(conn, :index)
    end

    test "change changes the cart contents", %{conn: conn, dish_id: dish_id} do
      conn = put(conn, Routes.cart_path(conn, :update, "change"), cart_params: %{dish_id => "25"})

      assert redirected_to(conn) == Routes.cart_path(conn, :index)

      conn = get(conn, Routes.cart_path(conn, :index))
      assert html_response(conn, 200) =~ "25"
    end

    test "add adds items to the pre-existing cart", %{conn: conn, dish_id: dish_id} do
      conn = put(conn, Routes.cart_path(conn, :update, "add"), cart_params: %{dish_id => "116"})

      assert redirected_to(conn) == Routes.cart_path(conn, :index)

      conn = get(conn, Routes.cart_path(conn, :index))
      assert html_response(conn, 200) =~ "117"
    end
  end
end
