defmodule PlatformWeb.ArticleController do
    use PlatformWeb, :controller

    alias Platform.Article

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, %{"slug" => slug}) do
        case Article.get_by_slug(slug) do
            nil ->
                conn
                |> put_status(:not_found)
                |> put_view(PlatformWeb.ErrorView)
                |> render(:"404")
            article ->
                related_articles = Platform.Article.all |> Enum.slice(0, 3)
                render(conn, "index.html",
                    [
                        article: article,
                        related_articles: related_articles,
                        page_title: article.title,
                    ]
                )
        end
    end
end
