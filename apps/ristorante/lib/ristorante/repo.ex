defmodule Ristorante.Repo do
  use Ecto.Repo,
    otp_app: :ristorante,
    adapter: Ecto.Adapters.Postgres
end
