defmodule RistoranteWeb.UserControllerTest do
  use RistoranteWeb.ConnCase

  # alias Ristorante.Accounts

  @create_attrs %{
    address: "some address",
    email: "email@email.com",
    first_name: "some first_name",
    last_name: "some last_name",
    password: "some password",
    username: "some username"
  }
  @update_attrs %{
    address: "some updated address",
    email: "updated@email.com",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    password: "updated password",
    username: "updated username"
  }
  @invalid_attrs %{
    address: nil,
    email: nil,
    first_name: nil,
    last_name: nil,
    password: nil,
    username: nil
  }

  # def fixture(:user) do
  #  {:ok, user} = Accounts.create_user(@create_attrs)
  #  user
  # end

  # describe "index" do
  #  test "lists all users", %{conn: conn} do
  #    conn = get(conn, Routes.user_path(conn, :index))
  #    assert html_response(conn, 200) =~ "Listing Users"
  #  end
  # end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :show, id)

      conn = get(conn, Routes.user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Your Account"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup %{conn: conn, login_as: username} do
      user = user_fixture(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    end

    @tag login_as: "User"
    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup %{conn: conn, login_as: username} do
      user = user_fixture(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    end

    @tag login_as: "User"
    test "redirects when data is valid", %{conn: conn, user: user} do
      update_conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(update_conn) == Routes.user_path(update_conn, :show, user)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert html_response(conn, 200) =~ "some updated address"
    end

    @tag login_as: "User"
    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  # describe "delete user" do
  #  setup [:create_user]

  #  test "deletes chosen user", %{conn: conn, user: user} do
  #    conn = delete(conn, Routes.user_path(conn, :delete, user))
  #    assert redirected_to(conn) == Routes.user_path(conn, :index)

  #    assert_error_sent 404, fn ->
  #      get(conn, Routes.user_path(conn, :show, user))
  #    end
  #  end
  # end

  # defp create_user(_) do
  #  user = fixture(:user)
  #  {:ok, user: user}
  # end
end
