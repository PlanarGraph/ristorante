defmodule Ristorante.Transactions.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    field :items, :map
    field :total, :float

    belongs_to :user, Ristorante.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:items, :total, :user_id])
    |> validate_required([:items, :total, :user_id])
    |> assoc_constraint(:user)
  end
end
