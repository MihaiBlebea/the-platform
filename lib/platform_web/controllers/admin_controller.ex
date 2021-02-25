defmodule PlatformWeb.AdminController do
    use PlatformWeb, :controller

    alias Platform.{PageView, User}

    plug PlatformWeb.MemberPlug, [roles: [:admin]] when action in [
        :index
    ]

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _params) do
        page_views = PageView.get_top_pages_today
        today_regs = User.get_registrations_count_today
        regs = User.get_total_users

        conn
        |> render("index.html", [page_views: page_views, today_regs: today_regs, regs: regs])
    end
end
