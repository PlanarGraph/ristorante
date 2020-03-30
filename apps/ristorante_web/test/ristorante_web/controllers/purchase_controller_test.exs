defmodule RistoranteWeb.PurchaseControllerTest do
  use RistoranteWeb.ConnCase

  alias Ristorante.Transactions
  alias Ristorante.Food
  alias Ristorante.Transactions.Purchase

  describe "new purchase" do
    setup %{conn: conn} do
      user = user_fixture()
      {:ok, dish} = Food.create_dish(%{name: "Tofu", price: 8.69})
      cart = %{num_items: 1, items: %{dish.id => 1}}

      conn =
        conn
        |> assign(:current_user, user)
        |> assign(:cart, cart)

      {:ok, conn: conn}
    end

    test "renders with logged in user", %{conn: conn} do
      conn = get(conn, Routes.purchase_path(conn, :new))

      assert html_response(conn, 200) =~ "Confirm Your Purchase"
    end

    test "renders cart items and prices", %{conn: conn} do
      conn = get(conn, Routes.purchase_path(conn, :new))

      assert html_response(conn, 200) =~ "Tofu"
      assert html_response(conn, 200) =~ "8.69"
    end
  end

  describe "create purchase" do
    setup %{conn: conn} do
      user = user_fixture()
      {:ok, dish} = Food.create_dish(%{name: "Tofu", price: 8.69})
      cart = %{num_items: 1, items: %{dish.id => 1}}

      conn =
        conn
        |> assign(:current_user, user)
        |> assign(:cart, cart)

      {:ok, conn: conn}
    end

    test "successful create redirects", %{conn: conn} do
      conn = post(conn, Routes.purchase_path(conn, :create))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.purchase_path(conn, :show, id)
    end
  end

  describe "show purchase" do
    setup %{conn: conn} do
      user = user_fixture()
      {:ok, dish} = Food.create_dish(%{name: "Tofu", price: 8.69})

      {:ok, purchase} =
        Transactions.create_purchase(%{
          total: 13.50,
          user_id: user.id,
          items: %{dish.id => 5}
        })

      conn =
        conn
        |> assign(:current_user, user)

      {:ok, conn: conn, purchase_id: purchase.id}
    end

    test "renders if user made purchase", %{conn: conn, purchase_id: purchase_id} do
      conn = get(conn, Routes.purchase_path(conn, :show, purchase_id))

      assert html_response(conn, 200) =~ "Transaction ##{purchase_id}"
    end

    test "redirects if unauthorized", %{conn: conn, purchase_id: purchase_id} do
      user2 = user_fixture(username: "unauth")

      conn =
        conn
        |> assign(:current_user, user2)
        |> get(Routes.purchase_path(conn, :show, purchase_id))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
