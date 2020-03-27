defmodule RistoranteWeb.FoodView do
  use RistoranteWeb, :view

  defp image_name(dish) do
    dish.name
    |> String.downcase()
    |> String.split(" ")
    |> Enum.join()
  end

  def image_link(dish, path) do
    path <> image_name(dish) <> ".jpg"
  end

  def format_price(dish) do
    "$" <> :erlang.float_to_binary(dish.price, decimals: 2)
  end
end
