defmodule PlatformWeb.Router do
    use PlatformWeb, :router

    alias PlatformWeb.{PageViewPlug,AuthUserPlug}

    pipeline :browser do
        plug :accepts, ["html"]
        plug :fetch_session
        plug :fetch_flash
        plug :protect_from_forgery
        plug :put_secure_browser_headers
        plug PageViewPlug
        plug AuthUserPlug
    end

    pipeline :api do
        plug :accepts, ["json"]
    end

    scope "/", PlatformWeb do
        pipe_through :browser

        get "/", PageController, :index
        post "/contact", PageController, :contact

        get "/article", ArticleController, :get_create
        post "/article", ArticleController, :post_create
        get "/article/update/:id", ArticleController, :get_update
        post "/article/update/:id", ArticleController, :post_update
        get "/article/list", ArticleController, :list
        post "/article/delete", ArticleController, :delete
        get "/article/:slug", ArticleController, :index

        get "/tag/:slug", TagController, :index

        get "/member/register", MembershipController, :get_register
        post "/member/register", MembershipController, :post_register
        get "/member/login", MembershipController, :get_login
        post "/member/login", MembershipController, :post_login
        get "/member/logout", MembershipController, :logout
        get "/member", MembershipController, :index
        get "/member/:course", MembershipController, :get_course
        get "/member/:course/:lesson", MembershipController, :get_lesson

        get "/admin", AdminController, :index

        post "/subscribe", MarketingController, :subscribe
    end

    # Other scopes may use custom stacks.
    scope "/api/v1", PlatformWeb do
        pipe_through :api

        post "/tag", ApiController, :create_tag
        put "/tag/:id", ApiController, :update_tag
        delete "/tag/:id", ApiController, :delete_tag
        get "/tags", ApiController, :list_tags

        post "/article", ApiController, :create_article
        put "/article/:id", ApiController, :update_article
        put "/article/:id/assign-tags", ApiController, :assign_tags_article
        delete "/article/:id", ApiController, :delete_article
        get "/articles", ApiController, :list_articles

        get "/users", ApiController, :list_users

        get "/views", ApiController, :list_views
        get "/subscribers", ApiController, :list_subscribers
    end

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
