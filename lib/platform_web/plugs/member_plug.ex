defmodule PlatformWeb.MemberPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.User

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), Plug.opts) :: Plug.Conn.t()
    def call(conn, [roles: roles]) do
        if user_id = get_session(conn, :auth_user_id) do
            case User.get_by_id(user_id) do
                nil -> conn |> failed_auth
                user ->
                    roles
                    |> Enum.member?(get_user_role_label(user))
                    |> case do
                        true -> conn |> assign(:auth_user, user)
                        false -> conn |> failed_auth
                    end
            end
        else
            conn |> failed_auth
        end
    end

    def call(conn, []) do
        if user_id = get_session(conn, :auth_user_id) do
            case User.get_by_id(user_id) do
                nil -> conn |> failed_auth
                user -> conn |> assign(:auth_user, user)
            end
        else
            conn |> failed_auth
        end
    end

    defp failed_auth(conn) do
        conn
        |> put_flash(:error, "You need to be signed in to access this page")
        |> redirect(to: "/member/login")
        |> halt()
    end

    defp get_user_role_label(user) do
        case user.role do
            nil -> :fail
            role -> String.to_atom(role.label)
        end
    end
end
