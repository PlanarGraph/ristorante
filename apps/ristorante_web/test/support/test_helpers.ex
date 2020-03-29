defmodule RistoranteWeb.TestHelpers do
  alias Ristorante.{
    Accounts,
    Food
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        address: "some address",
        email: "email@email.com",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        username: "some username"
      })
      |> Accounts.register_user()

    user
  end

  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "Default"
      })
      |> Food.create_category()

    category
  end

  def dish_fixture(attrs \\ %{}) do
    {:ok, dish} =
      attrs
      |> Enum.into(%{
        name: "a dish",
        price: 10.0,
        category_id: 1,
        description: "sample description"
      })
      |> Food.create_dish()

    dish
  end
end
