defmodule PlatformWeb.ApiController do
    use PlatformWeb, :controller

    alias Platform.{PageView}

    plug PlatformWeb.ApiMemberPlug when action in [
        :page_views_dashboard
    ]

    @spec page_views_dashboard(Plug.Conn.t(), any) :: Plug.Conn.t()
    def page_views_dashboard(conn, _params) do
        page_views = PageView.all_count_by_day

        conn |> json(page_views)
    end
end
