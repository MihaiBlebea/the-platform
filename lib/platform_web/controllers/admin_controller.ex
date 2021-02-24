defmodule PlatformWeb.AdminController do
    use PlatformWeb, :controller

    plug PlatformWeb.MemberPlug, [roles: [:admin]] when action in [
        :index
    ]

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _params) do
        conn |> render("index.html", [])
    end
end
