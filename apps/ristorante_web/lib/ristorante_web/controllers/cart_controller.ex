defmodule RistoranteWeb.CartController do
  use RistoranteWeb, :controller

  alias RistoranteWeb.Basket
  alias Ristorante.Food

  def index(conn, _params) do
    items = conn.assigns[:cart][:items] || %{}

    dishes =
      items
      |> Map.keys()
      |> Food.list_dishes_by_ids()
      |> Enum.map(fn x -> {x.id, x} end)
      |> Enum.into(%{})

    render(conn, "index.html", dishes: dishes)
  end

  def update(conn, %{"id" => id, "cart_params" => cart_params}) do
    cart_update =
      cart_params
      |> Enum.map(fn {id, quantity} ->
        {String.to_integer(id), String.to_integer(quantity)}
      end)

    case id do
      "change" -> Basket.update_items(conn, cart_update)
      "add" -> Basket.add_items(conn, cart_update)
      _ -> conn
    end
    |> redirect(to: Routes.cart_path(conn, :index))
  end
end
