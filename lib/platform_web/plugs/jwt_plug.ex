defmodule PlatformWeb.JwtPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.User

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), list) :: Plug.Conn.t()
    def call(conn, _opts) do
        conn |> handle_token_request(conn.query_params)
    end

    defp handle_token_request(conn, %{"token" => token}) do
        case User.get_by_token(token) do
            nil -> conn |> failed_auth
            user ->
                case user.role.label do
                    "admin" -> conn
                    _ -> conn |> failed_auth
                end
        end
    end

    defp handle_token_request(conn, _query_params), do: conn |> failed_auth

    defp failed_auth(conn), do: conn |> put_status(401) |> json(%{error: "No auth"}) |> halt
end
