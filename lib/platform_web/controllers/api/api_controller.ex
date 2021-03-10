defmodule PlatformWeb.ApiController do
    use PlatformWeb, :controller

    alias Platform.{User, Tag, Article, Subscriber, PageView}

    plug PlatformWeb.JwtPlug

    @spec create_article(Plug.Conn.t(), map) :: any
    def create_article(conn, %{
        "title" => _title,
        "image_url" => _image_url,
        "content_url" => _content_url,
        "slug" => slug,
        "description" => _description} = request) do

        case Article.get_by_slug(slug) do
            nil ->
                request
                |> Map.put("active", false)
                |> Article.save
                |> case do
                    {:ok, article} -> conn |> success_request(article, "Article saved")
                    {:error, _err} -> conn |> invalid_request
                end
            article -> conn |> success_request(article, "Article already exists")
        end
    end

    @spec update_article(Plug.Conn.t(), map) :: any
    def update_article(conn, %{"id" => id} = request) do
        case Article.update(id, request) do
            {:ok, article} -> conn |> success_request(article, "Article updated")
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec assign_tags_article(Plug.Conn.t(), map) :: any
    def assign_tags_article(conn, %{"id" => id, "tags_id" => tags_id}) do
        case Article.update_tags_by_ids(id, tags_id) do
            {:ok, article} -> conn |> success_request(article, "Article updated")
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec delete_article(Plug.Conn.t(), any) :: Plug.Conn.t()
    def delete_article(conn, %{"id" => id}) do
        case Article.get_by_id(id) do
            nil -> conn |> json(%{"message" => "Article was not deleted"})
            article ->
                case Article.delete(article) do
                    {:ok, _tag} -> conn |> success_request(article, "Article deleted")
                    {:error, _err} -> conn |> invalid_request("Could not delete article")
                end
        end
    end

    @spec list_articles(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_articles(conn, _opts) do
        conn |> success_request(Article.all)
    end

    @spec create_tag(Plug.Conn.t(), map) :: any
    def create_tag(conn, %{"label" => label, "active" => _active} = request) do
        case Tag.get_by_label(label) do
            nil ->
                case Tag.save(request) do
                    {:ok, tag} -> conn |> success_request(tag, "Tag saved")
                    {:error, _err} -> conn |> invalid_request
                end
            tag -> conn |> success_request(tag, "Tag already exists")
        end
    end

    @spec update_tag(Plug.Conn.t(), map) :: Plug.Conn.t()
    def update_tag(conn, %{"id" => id} = request) do
        case Tag.update(id, request) do
            {:ok, tag} -> conn |> success_request(tag, "Tag updated")
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec list_tags(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_tags(conn, _opts) do
        conn |> success_request(Tag.all)
    end

    @spec delete_tag(Plug.Conn.t(), any) :: Plug.Conn.t()
    def delete_tag(conn, %{"id" => id}) do
        case Tag.get_by_id(id) do
            nil -> conn |> invalid_request("Could not find tag by id")
            tag ->
                if length(tag.articles) > 0 do
                    conn |> invalid_request("Could not delete tag. Delete tag articles first")
                end

                case Tag.delete(tag) do
                    {:ok, _tag} -> conn |> success_request(tag, "Tag deleted")
                    {:error, _err} -> conn |> invalid_request("Could not delete tag")
                end
        end
    end

    @spec list_users(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_users(conn, _opts) do
        conn |> success_request(User.all)
    end

    @spec list_subscribers(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_subscribers(conn, _opts) do
        total = Subscriber.get_total_subscribers
        today = Subscriber.get_subscribers_today

        conn |> success_request(%{total: total, today: today})
    end

    @spec list_views(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_views(conn, _opts) do
        views = PageView.all_count_by_day
        per_page_views = PageView.get_top_pages_today

        conn |> success_request(%{views: views, per_page_views: per_page_views})
    end

    defp success_request(conn, resources, message) do
        conn |> put_status(200) |> json(%{"message" => message, "resources" => resources})
    end

    defp success_request(conn, resources) do
        conn |> success_request(resources, "Request successful")
    end

    defp invalid_request(conn), do: conn |> invalid_request("Invalid request")

    defp invalid_request(conn, message), do: conn |> put_status(400) |> json(%{"message" => message, "resources" => []})
end
