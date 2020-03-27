defmodule RistoranteWeb.FoodView do
  use RistoranteWeb, :view

  def format_price(dish) do
    "$" <> :erlang.float_to_binary(dish.price, decimals: 2)
  end
end
