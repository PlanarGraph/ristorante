# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ristorante.Repo.insert!(%Ristorante.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Ristorante.Food

categories = ~w(Appetisers Sandwiches Entrees Desserts)

for category <- categories do
  Food.create_catgeory!(category)
end

category_map =
  categories
  |> Enum.map(&Food.get_category_by(name: &1))
  |> Enum.map(fn cat -> {cat.name, cat.id} end)
  |> Enum.into(%{})

sandwiches =
  [
    %{name: "Hamburger", price: 13.50, description: "A succulent burger!"},
    %{name: "Cheese Steak", price: 15.50, description: "Our take on a Philly classic!"},
    %{name: "Chicken Wrap", price: 12.50, description: "Grilled chicken in wrap! Mmm good!"},
    %{
      name: "Meatball Sub",
      price: 15.00,
      description: "Our finest balled meat on a bun with sauce!"
    },
    %{name: "Vegan Wrap", price: 12.50, description: "A delicious vegan meal!"}
  ]
  |> Enum.map(&Map.put(&1, :category_id, category_map["Sandwiches"]))

for sandwich <- sandwiches do
  Food.create_dish(sandwich)
end

pastas =
  [
    %{name: "Bowl O Basil", price: 17.00, description: "A delicious green pasta dish!"},
    %{name: "Lasagna", price: 18.00, description: "Our secret family recipe lasagna!"},
    %{name: "Penne", price: 18.50, description: "Penne, sauce, what could be better?"},
    %{name: "ShrimPasta", price: 21.00, description: "We're going to need a bigger bowl!"},
    %{name: "Spaghetti", price: 19.00, description: "An Italian classic!"}
  ]
  |> Enum.map(&Map.put(&1, :category_id, category_map["Pasta"]))

for pasta <- pastas do
  Food.create_dish(pasta)
end

apps =
  [
    %{name: "Garlic Bread", price: 9.50, description: "With or without cheese!"},
    %{name: "Nachos", price: 12.50, description: "Add your choice of meat!"},
    %{name: "Quesadillas", price: 11.00, description: "Delicious, cheesy, quesadillas!"}
  ]
  |> Enum.map(&Map.put(&1, :category_id, category_map["Appetisers"]))

for app <- apps do
  Food.create_dish(app)
end
