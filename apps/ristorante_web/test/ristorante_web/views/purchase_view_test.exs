defmodule RistoranteWeb.PurchaseViewTest do
  use RistoranteWeb.ConnCase

  alias RistoranteWeb.PurchaseView

  test "formats correctly" do
    price = 25.52
    assert PurchaseView.format_price(price) == "$25.52"
  end

  test "adds two decimal places" do
    price = 10.0
    assert PurchaseView.format_price(price) == "$10.00"
  end

  test "rounds to two decimals" do
    price = 300.5674
    assert PurchaseView.format_price(price) == "$300.57"
  end
end
