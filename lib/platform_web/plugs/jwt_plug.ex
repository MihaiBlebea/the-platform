defmodule PlatformWeb.JwtPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.{Jwt}

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), list) :: Plug.Conn.t()
    def call(conn, _opts) do
        conn |> handle_token_request(conn.query_params)
    end

    defp handle_token_request(conn, %{"token" => token}) do
        case Jwt.resource_from_token(token) do
            {:ok, user, _claims} ->
                case user.role.label do
                    "admin" -> conn
                    _ -> conn |> failed_auth
                end
            {:error, _err} -> conn |> failed_auth
        end
    end

    defp handle_token_request(conn, _query_params) do
        token = conn |> extract_bearer_token

        handle_token_request(conn, %{"token" => token})
    end

    defp extract_bearer_token(conn) do
        conn.req_headers
        |> Enum.filter(fn ({key, _val}) -> key == "authorization" end)
        |> List.first
        |> found_bearer(conn)
        |> String.split
        |> List.last
        |> found_token(conn)
    end

    defp found_bearer({"authorization", bearer}, _conn), do: bearer

    defp found_bearer(nil, conn), do: conn |> failed_auth

    defp found_bearer(_, conn), do: conn |> failed_auth

    def found_token(nil, conn), do: conn |> failed_auth

    def found_token(token, _conn), do: token

    defp failed_auth(conn), do: conn |> put_status(401) |> json(%{error: "No auth"}) |> halt
end
