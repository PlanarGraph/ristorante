defmodule Ristorante.TransactionsTest do
  use Ristorante.DataCase

  alias Ristorante.Transactions

  describe "purchases" do
    alias Ristorante.Transactions.Purchase

    @valid_attrs %{items: %{}, total: 120.5}
    @update_attrs %{items: %{}, total: 456.7}
    @invalid_attrs %{items: nil, total: nil}

    def purchase_fixture(attrs \\ %{}) do
      {:ok, purchase} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_purchase()

      purchase
    end

    test "list_purchases/0 returns all purchases" do
      purchase = purchase_fixture()
      assert Transactions.list_purchases() == [purchase]
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert Transactions.get_purchase!(purchase.id) == purchase
    end

    test "create_purchase/1 with valid data creates a purchase" do
      assert {:ok, %Purchase{} = purchase} = Transactions.create_purchase(@valid_attrs)
      assert purchase.items == %{}
      assert purchase.total == 120.5
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{} = purchase} = Transactions.update_purchase(purchase, @update_attrs)
      assert purchase.items == %{}
      assert purchase.total == 456.7
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_purchase(purchase, @invalid_attrs)
      assert purchase == Transactions.get_purchase!(purchase.id)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = Transactions.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = Transactions.change_purchase(purchase)
    end
  end
end
