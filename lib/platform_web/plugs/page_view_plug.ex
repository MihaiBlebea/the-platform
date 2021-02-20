defmodule PlatformWeb.PageViewPlug do
    import Plug.Conn

    alias Platform.PageView

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), Plug.opts) :: Plug.Conn.t()
    def call(conn, _opts) do
        # conn
        # |> put_session(:user, %{name: "Jack"})
        PageView.save %{url: conn.request_path}

        conn
    end
end
