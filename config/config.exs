# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :learnit,
  ecto_repos: [Learnit.Repo]

# Added to manage HAML
config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# Configures the endpoint
config :learnit, Learnit.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LScbxbDE3jnYrTPMQbOf5ASn33EoHW6TK9yQlR6jJ0LeUiSmMoHFxaGax/TLS2P+",
  render_errors: [view: Learnit.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Learnit.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Learnit.User,
  repo: Learnit.Repo,
  module: Learnit,
  router: Learnit.Router,
  messages_backend: Learnit.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, Learnit.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
