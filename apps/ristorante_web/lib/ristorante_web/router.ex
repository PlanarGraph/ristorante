defmodule RistoranteWeb.Router do
  use RistoranteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RistoranteWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RistoranteWeb do
    pipe_through :browser

    resources "/users", UserController, only: [:show, :new, :create, :edit, :update]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RistoranteWeb do
  #   pipe_through :api
  # end
end
