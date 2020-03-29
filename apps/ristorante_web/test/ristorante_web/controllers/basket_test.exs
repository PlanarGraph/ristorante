defmodule RistoranteWeb.BasketTest do
  use RistoranteWeb.ConnCase
  alias RistoranteWeb.Basket

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(RistoranteWeb.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  test "basket added to session when loading home the first time", %{conn: conn} do
    assert get_session(conn, :cart) == %{num_items: 0, items: %{}}
  end

  test "empty_cart/1 empties the cart", %{conn: conn} do
    conn = put_session(conn, :cart, %{num_items: 1, items: %{1 => 1}})

    empty_conn = Basket.empty_cart(conn)

    assert get_session(empty_conn, :cart) == %{num_items: 0, items: %{}}
  end

  test "add_items/2 adds items to the cart", %{conn: conn} do
    conn = Basket.add_items(conn, %{1 => 1, 2 => 3})

    assert get_session(conn, :cart) == %{num_items: 4, items: %{1 => 1, 2 => 3}}
  end

  test "add_items/2 adds items to previously existing in the cart", %{conn: conn} do
    conn =
      conn
      |> put_session(:cart, %{num_items: 4, items: %{1 => 3, 4 => 1}})
      |> Basket.add_items(%{1 => 1, 4 => 1})

    assert get_session(conn, :cart) == %{num_items: 6, items: %{1 => 4, 4 => 2}}
  end

  test "update_items/2 updates items in the cart", %{conn: conn} do
    conn = Basket.update_items(conn, %{1 => 1, 5 => 2})

    assert get_session(conn, :cart) == %{num_items: 3, items: %{1 => 1, 5 => 2}}
  end

  test "update_items/2 removes items set to 0", %{conn: conn} do
    conn =
      conn
      |> put_session(:cart, %{num_items: 5, items: %{4 => 5}})
      |> Basket.update_items(%{4 => 0})

    assert get_session(conn, :cart) == %{num_items: 0, items: %{}}
  end
end
