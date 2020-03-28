defmodule Ristorante.TestHelpers do
  alias Ristorante.{
    Accounts
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "The",
        last_name: "User",
        address: "Home",
        email: "email@email.com",
        username: "user#{System.unique_integer([:positive])}",
        password: attrs[:password] || "supersecret"
      })
      |> Accounts.register_user()

    user
  end
end
