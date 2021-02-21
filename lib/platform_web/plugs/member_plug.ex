defmodule PlatformWeb.MemberPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.User

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), Plug.opts) :: Plug.Conn.t()
    def call(conn, _opts) do
        if user_id = get_session(conn, :auth_user_id) do
            auth_user = User.get_by_id(user_id)

            case auth_user do
                nil ->
                    conn
                    |> put_flash(:error, "You need to be signed in to access this page")
                    |> redirect(to: "/member/login")
                    |> halt()
                user -> conn |> assign(:auth_user, user)
            end
        else
            conn
            |> put_flash(:error, "You need to be signed in to access this page")
            |> redirect(to: "/member/login")
            |> halt()
        end
    end
end
