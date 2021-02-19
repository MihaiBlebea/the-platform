defmodule PlatformWeb.ArticleController do
    use PlatformWeb, :controller

    alias Platform.Article

    alias Platform.Tag

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, %{"slug" => slug}) do
        case Article.get_by_slug(slug) do
            nil ->
                conn
                |> put_status(:not_found)
                |> put_view(PlatformWeb.ErrorView)
                |> render(:"404")
            article ->
                related_articles = Article.all |> Enum.slice(0, 3)
                render(conn, "index.html",
                    [
                        article: article,
                        related_articles: related_articles,
                        page_title: article.title,
                    ]
                )
        end
    end

    @spec list(Plug.Conn.t(), map) :: Plug.Conn.t()
    def list(conn, _params) do
        render(conn, "list.html", articles: Article.all(), token: get_csrf_token())
    end

    @spec get_create(Plug.Conn.t(), map) :: Plug.Conn.t()
    def get_create(conn, _params) do
        tags = Tag.all()
        render(conn, "create.html", token: get_csrf_token(), tags: tags)
    end

    @spec post_create(Plug.Conn.t(), map) :: Plug.Conn.t()
    def post_create(conn, %{
        "title" => _title,
        "subtitle" => _subtitle,
        "image_url" => _image_url,
        "content_url" => _content_url,
        "slug" => _slug,
        "description" => _description,
        "tags" => _tags} = article) do

            case Article.save(article) do
                {:ok, article} ->
                    conn
                    |> put_flash(:info, "Article \"#{article.title}\" saved")
                    |> redirect(to: "/article/list")
                {:error, _error} ->
                    conn
                    |> put_flash(:info, "Something went wrong. Please try again")
                    |> redirect(to: conn.request_path)
            end
    end

    @spec get_update(Plug.Conn.t(), map) :: Plug.Conn.t()
    def get_update(conn, %{"id" => id}) do
        case Article.get_by_id(id) do
            nil ->
                conn
                |> put_status(:not_found)
                |> put_view(PlatformWeb.ErrorView)
                |> render(:"404")
            article ->
                conn
                |> render("create.html", update_article: article, token: get_csrf_token())
        end
    end

    @spec post_update(Plug.Conn.t(), map) :: Plug.Conn.t()
    def post_update(conn, %{
        "id" => id,
        "title" => _title,
        "subtitle" => _subtitle,
        "image_url" => _image_url,
        "content_url" => _content_url,
        "slug" => _slug,
        "description" => _description} = article) do

            case Article.update(id, article) do
                {:ok, article} ->
                    conn
                    |> put_flash(:info, "Article \"#{article.title}\" updated")
                    |> redirect(to: "/article/list")
                {:error, _error} ->
                    conn
                    |> put_flash(:info, "Something went wrong. Please try again")
                    |> redirect(to: conn.request_path)
            end
    end

    @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
    def delete(conn, %{"id" => id}) do
        case Article.get_by_id(id) do
            nil ->
                conn
                |> put_flash(:info, "Something went wrong. Please try again")
                |> redirect(to: conn.request_path)
            article ->
                case Article.delete(article) do
                    {:ok, _article} ->
                        conn
                        |> put_flash(:info, "Article deleted")
                        |> redirect(to: "/article/list")
                    {:error, _changeset} ->
                        conn
                        |> put_flash(:info, "Something went wrong. Please try again")
                        |> redirect(to: conn.request_path)
                end
        end
    end
end
