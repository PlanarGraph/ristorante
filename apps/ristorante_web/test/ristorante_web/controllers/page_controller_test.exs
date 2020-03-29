defmodule RistoranteWeb.PageControllerTest do
  use RistoranteWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to my Ristorante!"
  end
end
