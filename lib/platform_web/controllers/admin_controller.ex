defmodule PlatformWeb.AdminController do
    use PlatformWeb, :controller

    alias Platform.{PageView, User, ContactMessage, Subscriber}

    plug PlatformWeb.MemberPlug, [roles: [:admin]] when action in [
        :index
    ]

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _params) do
        dashboard = PageView.all_count_by_day
        page_views = PageView.get_top_pages_today
        today_regs = User.get_registrations_count_today
        regs = User.get_total_users
        contact_messages = ContactMessage.get_today
        total_subs = Subscriber.get_total_subscribers
        today_subs = Subscriber.get_subscribers_today
        admin_token = conn.assigns[:auth_user].token

        conn
        |> render("index.html", [
            dashboard: dashboard,
            page_views: page_views,
            today_regs: today_regs,
            regs: regs,
            contact_messages: contact_messages,
            total_subs: total_subs,
            today_subs: today_subs,
            admin_token: admin_token
        ])
    end
end
