defmodule PlatformWeb.PageController do
    use PlatformWeb, :controller

    alias PlatformWeb.Pagination

    alias Platform.{Course, Article}

    @articles_per_page 10

    @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
    def index(conn, _params) do
        articles = Article.all_active
        current_page = conn |> Pagination.get_current_page
        meta = articles |> Pagination.paginate(@articles_per_page, current_page)
        case current_page < 1 or current_page > Pagination.get_total_pages(articles, @articles_per_page) do
            true ->
                conn
                |> put_status(:not_found)
                |> put_view(PlatformWeb.ErrorView)
                |> render(:"404")
            false ->
                articles_paginated =
                    articles
                    |> Enum.chunk_every(@articles_per_page)
                    |> Enum.at(current_page - 1)
                courses = Course.all

                conn |> render("index.html",
                    [
                        token: get_csrf_token(),
                        articles: articles_paginated,
                        meta: meta,
                        courses: courses
                    ]
                )
        end
    end

    @spec contact(Plug.Conn.t(), map) :: Plug.Conn.t()
    def contact(conn, %{"name" => name, "email" => email, "phone" => phone, "message" => message}) do

        case Platform.Slack.contact_form(name, email, phone, message) do
            :ok ->
                conn
                |> put_flash(:info, "Your message has been sent")
                |> redirect(to: "/")
            _ ->
                conn
                |> put_flash(:error, "We were not able to send your message at this time. Please try again later")
                |> redirect(to: "/")
        end
    end
end
