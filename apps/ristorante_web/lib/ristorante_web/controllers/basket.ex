defmodule RistoranteWeb.Basket do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    cart = get_session(conn, :cart)

    case cart do
      nil ->
        empty_cart = %{num_items: 0, items: %{}}

        conn
        |> put_session(:cart, empty_cart)
        |> assign(:cart, empty_cart)

      _ ->
        conn
        |> assign(:cart, cart)
    end
  end

  def empty_cart(conn) do
    put_session(conn, :cart, %{})
  end

  def add_items(conn, id, quantity) do
    cart =
      conn
      |> get_session(:cart)
      |> Map.update!(:items, fn items ->
        Map.update(items, id, quantity, &(&1 + quantity))
      end)
      |> Map.update!(:num_items, &(&1 + quantity))

    conn
    |> put_session(:cart, cart)
    |> assign(:cart, cart)
  end
end
