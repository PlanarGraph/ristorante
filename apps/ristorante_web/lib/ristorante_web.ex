defmodule RistoranteWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use RistoranteWeb, :controller
      use RistoranteWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: RistoranteWeb
      import Plug.Conn
      import RistoranteWeb.Gettext
      import RistoranteWeb.Auth, only: [authenticate_user: 2, check_auth: 2]
      import RistoranteWeb.Basket, only: [nonempty_cart: 2]
      alias RistoranteWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/ristorante_web/templates",
        namespace: RistoranteWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import RistoranteWeb.ErrorHelpers
      import RistoranteWeb.Gettext
      alias RistoranteWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import RistoranteWeb.Auth, only: [authenticate_user: 2, check_auth: 2]
      import RistoranteWeb.Basket, only: [nonempty_cart: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import RistoranteWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
