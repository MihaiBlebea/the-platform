defmodule PlatformWeb.ApiController do
    use PlatformWeb, :controller

    alias Platform.{PageView, Tag, Article}

    plug PlatformWeb.JwtPlug

    @spec create_article(Plug.Conn.t(), map) :: any
    def create_article(conn, %{
        "title" => _title,
        "image_url" => _image_url,
        "content_url" => _content_url,
        "slug" => _slug,
        "description" => _description} = request) do

        request
        |> Map.put("active", false)
        |> Article.save
        |> case do
            {:ok, tag} -> conn |> json(tag)
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec update_article(Plug.Conn.t(), map) :: any
    def update_article(conn, %{"id" => id} = request) do
        case Article.update(id, request) do
            {:ok, tag} -> conn |> json(tag)
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec delete_article(Plug.Conn.t(), any) :: Plug.Conn.t()
    def delete_article(conn, %{"id" => id}) do
        case Article.get_by_id(id) do
            nil -> conn |> json(%{"message" => "Article was not deleted"})
            article ->
                case Article.delete(article) do
                    {:ok, _tag} -> conn |> json(%{"message" => "Article was deleted"})
                    {:error, _err} -> conn |> invalid_request("Could not delete article")
                end
        end
    end

    @spec list_articles(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_articles(conn, _opts) do
        conn |> json(%{"articles" => Article.all})
    end

    @spec create_tag(Plug.Conn.t(), map) :: any
    def create_tag(conn, %{"label" => _label, "active" => _active} = request) do
        case Tag.save(request) do
            {:ok, tag} -> conn |> json(tag)
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec update_tag(Plug.Conn.t(), map) :: Plug.Conn.t()
    def update_tag(conn, %{"id" => id} = request) do
        case Tag.update(id, request) do
            {:ok, tag} -> conn |> json(tag)
            {:error, _err} -> conn |> invalid_request
        end
    end

    @spec list_tags(Plug.Conn.t(), any) :: Plug.Conn.t()
    def list_tags(conn, _opts) do
        conn |> json(%{"tags" => Tag.all})
    end

    @spec delete_tag(Plug.Conn.t(), any) :: Plug.Conn.t()
    def delete_tag(conn, %{"id" => id}) do
        case Tag.get_by_id(id) do
            nil -> conn |> json(%{"message" => "Tag was not deleted"})
            tag ->
                if length(tag.articles) > 0 do
                    conn |> invalid_request("Could not delete tag. Delete tag articles first")
                end

                case Tag.delete(tag) do
                    {:ok, _tag} -> conn |> json(%{"message" => "Tag was deleted"})
                    {:error, _err} -> conn |> invalid_request("Could not delete tag")
                end
        end
    end

    defp invalid_request(conn), do: conn |> invalid_request("Invalid request")

    defp invalid_request(conn, message), do: conn |> put_status(400) |> json(%{"message" => message})
end
