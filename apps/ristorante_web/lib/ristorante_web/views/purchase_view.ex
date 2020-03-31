defmodule RistoranteWeb.PurchaseView do
  use RistoranteWeb, :view

  def format_price(price) do
    "$" <> :erlang.float_to_binary(price, decimals: 2)
  end
end
