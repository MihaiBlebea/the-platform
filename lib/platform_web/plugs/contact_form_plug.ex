defmodule PlatformWeb.ContactFormPlug do
    import Plug.Conn

    import Phoenix.Controller

    @spec init(any) :: any
    def init(options), do: options

    @spec call(Plug.Conn.t(), Plug.opts) :: Plug.Conn.t()
    def call(conn, _opts) do
        now = DateTime.now!("Etc/UTC")
        case get_session(conn, :contact_form_sent) do
            nil ->
                conn |> set_expire_date(now)
            datetime ->
                DateTime.compare(datetime, now)
                |> should_trigger_limit(conn, now)
        end
    end

    # This should not trigger the rate limiter
    defp should_trigger_limit(:lt, conn, now), do: conn |> set_expire_date(now)

    # This should trigger the rate limiter
    defp should_trigger_limit(:gt, conn, _now) do
        conn
        |> put_flash(:error, "This is akward. It seems that you hit the rate limiter of the contact form, please try again later.")
        |> redirect(to: "/")
        |> halt()
    end

    defp set_expire_date(conn, now) do
        expire = now |> DateTime.add(30 * 60, :second, Tzdata.TimeZoneDatabase)
        conn
        |> put_session(:contact_form_sent, expire)
    end
end
