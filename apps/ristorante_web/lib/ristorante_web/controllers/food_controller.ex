defmodule RistoranteWeb.FoodController do
  use RistoranteWeb, :controller

  alias Ristorante.Food

  def show(conn, %{"id" => category}) do
    food = Food.get_food_by_category(category)

    render(conn, "show.html", food: food)
  end
end
