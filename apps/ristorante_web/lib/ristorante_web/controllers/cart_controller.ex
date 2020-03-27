defmodule RistoranteWeb.CartController do
  use RistoranteWeb, :controller

  alias RistoranteWeb.Basket

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def update(conn, %{"id" => id, "cart_params" => %{"quantity" => quantity}}) do
    quantity = String.to_integer(quantity)

    conn
    |> Basket.add_items(id, quantity)
    |> render("index.html")
  end
end
