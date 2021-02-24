defmodule PlatformWeb.ApiMemberPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.User

    @cookie_key "_platform_key"

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), list) :: Plug.Conn.t()
    def call(conn, _opts) do
        conn
        |> get_user_id
        |> case do
            nil -> conn |> failed_auth
            user_id ->
                user = User.get_by_id(user_id)

                user
                |> case do
                    nil -> conn |> failed_auth
                    _user -> conn
                end
        end
    end

    defp get_user_id(conn) do
        [_, payload, _] = String.split(conn.req_cookies[@cookie_key], ".", parts: 3)
        {:ok, encoded_term } = Base.url_decode64(payload, padding: false)

        :erlang.binary_to_term(encoded_term)
        |> Map.get("auth_user_id", nil)
    end

    defp failed_auth(conn), do: conn |> put_status(401) |> json(%{error: "No auth"}) |> halt
end
