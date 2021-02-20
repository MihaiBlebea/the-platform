# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :platform,
    ecto_repos: [Platform.Repo]

# Configures the endpoint
config :platform, PlatformWeb.Endpoint,
    url: [host: "localhost"],
    secret_key_base: "UTtEU/gOb+EIzQMVS7yuqFAtxjGOlIGNhfqfC7oJnPedTsv7HWddXZtJrTnAEUkf",
    render_errors: [view: PlatformWeb.ErrorView, accepts: ~w(html json), layout: false],
    pubsub_server: Platform.PubSub,
    live_view: [signing_salt: "uCWD4q9I"]

config :platform,
    github_url: "https://github.com/MihaiBlebea",
    youtube_url: "https://www.youtube.com/channel/UCR_g0G3YYE_zQVqZL0y7-dg",
    facebook_url: "https://www.facebook.com/blebea.serban",
    twitter_url: "https://twitter.com/MBlebea",
    linkedin_url: "https://www.linkedin.com/in/mihai-blebea-87353310b",
    download_cv_url: "https://github.com/MihaiBlebea/mihai_blebea_cv/raw/master/Mihai_Blebea_latest_CV.pdf",
    slack_webhook: System.get_env("SLACK_WEBHOOK")

# Configures Elixir's Logger
config :logger, :console,
    format: "$time $metadata[$level] $message\n",
    metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
