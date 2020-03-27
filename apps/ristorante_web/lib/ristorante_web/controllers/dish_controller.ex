defmodule RistoranteWeb.DishController do
  use RistoranteWeb, :controller

  alias Ristorante.Food

  def show(conn, %{"id" => id}) do
    dish = Food.get_food_by(id: id)

    render(conn, "show.html", dish: dish)
  end
end
