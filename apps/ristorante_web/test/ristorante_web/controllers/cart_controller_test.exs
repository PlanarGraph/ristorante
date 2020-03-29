defmodule Ristorante.CartControllerTest do
  use RistoranteWeb.ConnCase

  describe "cart index" do
    setup %{conn: conn} do
      conn =
        conn
        |> bypass_through(RistoranteWeb.Router, :browser)
        |> get("/")

      {:ok, conn: conn}
    end

    test "renders with items in cart", %{conn: conn} do
    end
  end
end
