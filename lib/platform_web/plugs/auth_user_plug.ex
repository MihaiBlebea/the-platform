defmodule PlatformWeb.AuthUserPlug do
    import Plug.Conn

    alias Platform.User

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), Plug.opts) :: Plug.Conn.t()
    def call(conn, _opts) do
        if user_id = get_session(conn, :auth_user_id) do
            case User.get_by_id(user_id) do
                nil -> conn
                user -> conn |> assign(:auth_user, user)
            end
        else
            conn
        end
    end
end
