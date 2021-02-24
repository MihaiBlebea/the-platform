defmodule PlatformWeb.AdminController do
    use PlatformWeb, :controller

    alias Platform.{PageView, User}

    plug PlatformWeb.MemberPlug, [roles: [:admin]] when action in [
        :index
    ]

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _params) do
        page_views = PageView.get_top_pages_today
        regs = User.get_registrations_count_today

        conn
        |> render("index.html", [page_views: page_views, registrations: regs])
    end
end
