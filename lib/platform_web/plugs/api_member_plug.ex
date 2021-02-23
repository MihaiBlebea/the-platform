defmodule PlatformWeb.ApiMemberPlug do
    import Plug.Conn

    import Phoenix.Controller

    alias Platform.User

    @cookie_key "_platform_key"

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), list) :: Plug.Conn.t()
    def call(conn, _opts) do
        [_, payload, _] = String.split(conn.req_cookies[@cookie_key], ".", parts: 3)
        {:ok, encoded_term } = Base.url_decode64(payload, padding: false)

        IO.inspect payload
        IO.inspect encoded_term

        :erlang.binary_to_term(encoded_term)
        |> IO.inspect
        |> Map.get("auth_user_id", nil)
        |> case do
            nil -> conn |> put_status(401) |> json(%{error: "No auth"}) |> halt
            user_id ->
                User.get_by_id(user_id)
                |> case do
                    nil -> conn |> put_status(401) |> json(%{error: "No auth"}) |> halt
                    _user -> conn
                end
        end
    end
end
