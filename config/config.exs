# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :ristorante,
  ecto_repos: [Ristorante.Repo]

config :ristorante_web,
  ecto_repos: [Ristorante.Repo],
  generators: [context_app: :ristorante]

# Configures the endpoint
config :ristorante_web, RistoranteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9G0TUV9Pl3v7W42HNS/NBD6opB6LCrUcIoXkV3mMcSeeoLpzhTo3EAYBUKmd9QCY",
  render_errors: [view: RistoranteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RistoranteWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "XUWcIWgB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
