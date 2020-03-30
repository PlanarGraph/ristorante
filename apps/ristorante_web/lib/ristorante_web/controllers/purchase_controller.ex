defmodule RistoranteWeb.PurchaseController do
  use RistoranteWeb, :controller

  alias Ristorante.Transactions
  alias Ristorante.Food

  plug :authenticate_user
  plug :nonempty_cart when action in [:new, :create]

  def new(conn, _) do
    items = conn.assigns[:cart][:items]
    dishes = get_dishes(items)

    render(conn, "new.html", dishes: dishes)
  end

  def create(conn, _) do
    items = conn.assigns[:cart][:items]

    cart_params = %{
      items: items,
      user_id: conn.assigns[:current_user].id,
      total: calculate_total(items)
    }

    case Transactions.create_purchase(cart_params) do
      {:ok, purchase} ->
        redirect(conn, to: Routes.purchase_path(conn, :show, purchase.id))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: Routes.purchase_path(conn, :new))
        |> halt()
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.assigns[:current_user].id
    purchase = Transactions.get_purchase_by(id: id)

    cond do
      purchase && purchase.user_id == user_id ->
        dishes = get_dishes(purchase.items)
        render(conn, "show.html", purchase: purchase, dishes: dishes)

      true ->
        conn
        |> put_flash(:error, "You do not have permission to view this transaction.")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end

  defp get_dishes(items) do
    items
    |> Map.keys()
    |> Food.list_dishes_by_ids()
    |> Enum.map(fn x -> {x.id, x} end)
    |> Enum.into(%{})
  end

  defp calculate_total(items) do
    dishes =
      items
      |> Map.keys()
      |> Ristorante.Food.list_dishes_by_ids()
      |> Enum.map(fn x -> {x.id, x} end)
      |> Enum.into(%{})

    items
    |> Enum.map(fn {item, quantity} ->
      dishes[item].price * quantity
    end)
    |> Enum.sum()
  end
end
