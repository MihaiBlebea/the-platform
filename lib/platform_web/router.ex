defmodule PlatformWeb.Router do
    use PlatformWeb, :router

    pipeline :browser do
        plug :accepts, ["html"]
        plug :fetch_session
        plug :fetch_flash
        plug :protect_from_forgery
        plug :put_secure_browser_headers
    end

    pipeline :api do
        plug :accepts, ["json"]
    end

    scope "/", PlatformWeb do
        pipe_through :browser

        get "/", PageController, :index
        get "/article/:slug", ArticleController, :index
        get "/member/register", MembershipController, :get_register
        post "/member/register", MembershipController, :post_register
        get "/member/login", MembershipController, :get_login
        post "/member/login", MembershipController, :post_login
        get "/member/logout", MembershipController, :logout
        get "/member", MembershipController, :index
        get "/member/:course", MembershipController, :lesson
        get "/member/:course/:lesson", MembershipController, :lesson
    end

    # Other scopes may use custom stacks.
    # scope "/api", PlatformWeb do
    #   pipe_through :api
    # end

    # Enables LiveDashboard only for development
    #
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    if Mix.env() in [:dev, :test] do
        import Phoenix.LiveDashboard.Router

        scope "/" do
        pipe_through :browser
        live_dashboard "/dashboard", metrics: PlatformWeb.Telemetry
        end
    end
end
