defmodule RistoranteWeb.Basket do
  import Plug.Conn
  import Phoenix.Controller

  alias RistoranteWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    session_cart = get_session(conn, :cart)

    cond do
      cart = conn.assigns[:cart] ->
        conn
        |> put_session(:cart, cart)
        |> assign(:cart, cart)

      session_cart ->
        conn
        |> put_session(:cart, session_cart)
        |> assign(:cart, session_cart)

      true ->
        empty_cart = %{num_items: 0, items: %{}}

        conn
        |> put_session(:cart, empty_cart)
        |> assign(:cart, empty_cart)
    end
  end

  def empty_cart(conn) do
    put_session(conn, :cart, %{num_items: 0, items: %{}})
  end

  def add_items(conn, cart_update) do
    change_items(conn, cart_update, fn {id, quantity}, cart ->
      Map.update(cart, id, quantity, &(&1 + quantity))
    end)
  end

  def update_items(conn, cart_update) do
    change_items(conn, cart_update, fn {id, quantity}, cart ->
      Map.put(cart, id, quantity)
    end)
  end

  defp change_items(conn, cart_update, f) do
    cart =
      conn
      |> get_session(:cart)
      |> Map.update!(:items, fn items ->
        Enum.reduce(cart_update, items, f)
        |> Enum.filter(fn {_, v} -> v != 0 end)
        |> Enum.into(%{})
      end)
      |> (fn cart ->
            Map.put(cart, :num_items, cart[:items] |> Map.values() |> Enum.sum())
          end).()

    conn
    |> put_session(:cart, cart)
    |> assign(:cart, cart)
  end

  def nonempty_cart(conn, _opts) do
    cart = conn.assigns[:cart]

    if cart && cart[:num_items] && cart[:num_items] > 0 do
      conn
    else
      conn
      |> put_flash(:error, "You must have items in your cart to access that page.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
