# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :banking_api,
  ecto_repos: [BankingApi.Repo]

# Configures the endpoint
config :banking_api, BankingApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ar2mUkhMoxS/T8VOzb8KK/tq7sX/YyKs5ESY9g0vGBc25gVlTJD3igdYYDC4ShVl",
  render_errors: [view: BankingApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankingApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :banking_api, BankingApi.Accounts.Guardian,
       issuer: "banking_api",
       secret_key: "uUh8GmIu59rvuJZRqaNIz1lYUPkLrmOkX7d/mlG/lT/LZnK0NLi6VGgijTW6xj2C"
config :money,
       default_currency: :BRL
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
