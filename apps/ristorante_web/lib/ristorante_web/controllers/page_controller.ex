defmodule RistoranteWeb.PageController do
  use RistoranteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
