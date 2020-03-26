defmodule RistoranteWeb.SessionController do
  use RistoranteWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Ristorante.Accounts.authenticate_by_uname_and_pass(username, password) do
      {:ok, user} ->
        conn
        |> RistoranteWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back #{user.first_name}!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password, please try again.")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RistoranteWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
