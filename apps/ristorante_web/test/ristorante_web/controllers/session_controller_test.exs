defmodule RistoranteWeb.SessionControllerTest do
  use RistoranteWeb.ConnCase

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Login"
    end
  end

  describe "create session" do
    setup %{conn: conn} do
      user = user_fixture(username: "User", password: "abc123")
      {:ok, conn: conn, user: user}
    end

    test "redirects to homepage on valid login", %{conn: conn, user: user} do
      conn =
        post(
          conn,
          Routes.session_path(conn, :create),
          session: %{"username" => "User", "password" => "abc123"}
        )

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "Welcome back #{user.first_name}"
    end

    test "invalid credentials renders new", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.session_path(conn, :create),
          session: %{"username" => "User", "password" => "topsecret"}
        )

      assert html_response(conn, 200) =~ "Login"
    end
  end

  describe "delete session" do
    setup %{conn: conn} do
      user = user_fixture(username: "User", password: "abc123")

      conn =
        conn
        |> bypass_through(RistoranteWeb.Router, :browser)
        |> get("/")
        |> put_session(:user_id, user.id)

      {:ok, conn: conn, user: user}
    end

    test "logs out user and redirects to home", %{conn: conn, user: user} do
      assert get_session(conn, :user_id) == user.id

      conn = delete(conn, Routes.session_path(conn, :delete, user))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
