defmodule PlatformWeb.TagController do
    use PlatformWeb, :controller

    alias PlatformWeb.Pagination

    alias Platform.{Article, Tag}

    @articles_per_page 2

    @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
    def index(conn, %{"slug" => slug}) do
        tag = Tag.get_by_label(slug)

        case tag != nil do
            false ->
                conn
                |> put_status(:not_found)
                |> put_view(PlatformWeb.ErrorView)
                |> render(:"404")

            true ->
                articles = tag.articles
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

                        conn |> render("index.html",
                            [
                                articles: articles_paginated |> Article.with_tags,
                                meta: meta,
                                tag: tag
                            ]
                        )
                end
        end
    end
end
