defmodule Ristorante.AccountsTest do
  use Ristorante.DataCase, async: true

  alias Ristorante.Accounts
  alias Ristorante.Accounts.User

  describe "register_user/1" do
    @valid_attrs %{
      username: "username",
      password: "secret123",
      email: "user@email.com",
      first_name: "The",
      last_name: "User",
      address: "Userland"
    }

    @invalid_attrs %{}

    test "valid data inserts user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.username == "username"
      assert user.email == "user@email.com"
      assert user.first_name == "The"
      assert user.last_name == "User"
      assert user.address == "Userland"
    end

    test "invalid data does not insert" do
      assert {:error, _reason} = Accounts.register_user(@invalid_attrs)
      assert Accounts.list_users() == []
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)
      assert %{username: ["has already been taken"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("z", 21))
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{username: ["should be at most 20 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires username to contain at least one character" do
      attrs = Map.put(@valid_attrs, :username, "")
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{username: ["can't be blank"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires password to be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "abc12")
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires password to at most 64 characters long" do
      attrs = Map.put(@valid_attrs, :password, String.duplicate("1", 65))
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{password: ["should be at most 64 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires email to have proper format" do
      attrs = Map.put(@valid_attrs, :email, "useratgibberish.com")
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{email: ["has invalid format"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_uname_and_pass/2" do
    @pass "123456"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} = Accounts.authenticate_by_uname_and_pass(user.username, @pass)
      assert auth_user.id == user.id
    end

    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} =
               Accounts.authenticate_by_uname_and_pass(user.username, "badpass")
    end

    test "returns not found error with no matching user for username" do
      assert {:error, :not_found} = Accounts.authenticate_by_uname_and_pass("unknownuser", @pass)
    end
  end
end
