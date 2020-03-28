use Mix.Config

# Configure your database
config :ristorante, Ristorante.Repo,
  username: "postgres",
  password: "psadmin",
  database: "ristorante_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ristorante_web, RistoranteWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :pbkdf2_elixir, :rounds, 1
