defmodule PlatformWeb.MarketingController do
    use PlatformWeb, :controller

    alias Platform.{EmailMarketing, Subscriber, Slack}

    @spec subscribe(Plug.Conn.t(), map) :: Plug.Conn.t()
    def subscribe(conn, %{"email" => email, "url" => url, "form_id" => _form_id} = request) do
        case EmailMarketing.subscribe(email) do
            :ok ->
                Subscriber.save(request)
                Slack.send_text("Somebody signed up for marketing newsletter")
                conn
                |> put_flash(:info, "Thank you for subscribing. Please check and confirm your email address")
                |> put_session(:subscriber, true)
                |> redirect(to: url)

            :fail ->
                conn
                |> put_flash(:error, "This is akward. Something did't work as expected. Please try again later")
                |> redirect(to: url)
        end
    end
end
