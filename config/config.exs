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
    download_cv_url: "https://github.com/MihaiBlebea/mihai_blebea_cv/raw/master/Mihai_Blebea_latest_CV.pdf"

# Email marketing
config :platform,
    ck_api_key: System.get_env("CONVERT_KIT_API_KEY"),
    ck_secret_key: System.get_env("CONVERT_KIT_SECRET_KEY"),
    ck_form_id: System.get_env("CONVERT_KIT_FORM_ID")

# Slack and github configs
config :platform,
    slack_webhook: System.get_env("SLACK_WEBHOOK"),
    github_token: System.get_env("GITHUB_TOKEN")

# Configures Elixir's Logger
config :logger, :console,
    format: "$time $metadata[$level] $message\n",
    metadata: [:request_id]

# JWT config
config :platform, Platform.Jwt,
    issuer: "the_platform",
    secret_key: System.get_env("SECRET_KEY_BASE")

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# config :platform, Platform.Scheduler,
#     jobs: [
#         [
#             schedule: "0 8 * * *",
#             run_strategy: Quantum.RunStrategy.Local,
#             task: {
#                 Platform.Report, :send_notification, []
#             }
#         ]
#     ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
