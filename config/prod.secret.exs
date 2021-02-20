# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

System.fetch_env!("MYSQL_USER") ||
        raise """
        environment variable MYSQL_USER is missing.
        """

database_url = "mysql://#{ System.get_env("MYSQL_HOST") }:#{ System.get_env("MYSQL_PORT") }/#{ System.get_env("MYSQL_DATABASE") }?user=#{ System.get_env("MYSQL_USER") }&password=#{ System.get_env("MYSQL_PASSWORD") }"
#   System.get_env("DATABASE_URL") ||
#     raise """
#     environment variable DATABASE_URL is missing.
#     For example: ecto://USER:PASS@HOST/DATABASE
#     """

config :platform, Platform.Repo,
    adapter: Ecto.Adapters.MySQL,
    username: System.get_env("MYSQL_USER"),
    password: System.get_env("MYSQL_PASSWORD"),
    database: System.get_env("MYSQL_DATABASE"),
    hostname: System.get_env("MYSQL_HOST"),
    port: System.get_env("MYSQL_PORT"),
    pool_size: 10

config :platform,
    slack_webhook: System.get_env("SLACK_WEBHOOK")

config :platform, Platform.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
        raise """
        environment variable SECRET_KEY_BASE is missing.
        You can generate one by calling: mix phx.gen.secret
        """

config :platform, PlatformWeb.Endpoint,
    http: [
        port: String.to_integer(System.get_env("HTTP_PORT") || "4000"),
        transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :platform, PlatformWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
config :platform, PlatformWeb.Endpoint, server: true
