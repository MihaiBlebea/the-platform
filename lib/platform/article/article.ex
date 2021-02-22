defmodule Platform.Article do
    use Ecto.Schema

    import Ecto.{Changeset, Query}

    alias Platform.{Article, Tag, Repo}

    @type t() :: %__MODULE__{}

    schema "articles" do
        field :content_url, :string
        field :image_url, :string
        field :description, :string
        field :slug, :string
        field :subtitle, :string
        field :title, :string
        field :active, :boolean, default: false

        timestamps()

        many_to_many(:tags, Tag, join_through: "article_tag", on_replace: :delete)
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(article, attrs) do
        article
        |> cast(attrs, [:title, :subtitle, :description, :image_url, :content_url, :slug, :active])
        |> validate_required([:title, :subtitle, :description, :image_url, :content_url, :slug, :active])
    end

    @spec update(integer, map) :: {:ok, __MODULE__.t()} | {:error, any}
    def update(id, changes) do
        case get_by_id(id) do
            nil -> {:error, "Model not found"}
            article ->
                article
                |> changeset(changes)
                |> Repo.update
        end
    end

    @spec update_tags(map, list) :: any
    def update_tags(article, tags) do
        changeset(article, %{})
        |> put_assoc(:tags, tags)
        |> Repo.update!
    end

    @spec update_tags_by_ids(integer, nil | list) :: any
    def update_tags_by_ids(article_id, nil), do: update_tags_by_ids(article_id, [])

    def update_tags_by_ids(article_id, tag_ids) do
        tags = Tag.get_in_id_list(tag_ids)

        article_id
        |> Article.get_by_id
        |> Article.update_tags(tags)
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(article) do
        changeset(%__MODULE__{}, article)
        |> Repo.insert
    end

    @spec get_by_slug(any) :: nil | Platform.Article.t()
    def get_by_slug(slug) do
        Repo.get_by(__MODULE__, slug: slug) |> Repo.preload(:tags)
    end

    @spec get_by_slug_active(any) :: nil | Platform.Article.t()
    def get_by_slug_active(slug) do
        Repo.get_by(__MODULE__, slug: slug, active: true) |> Repo.preload(:tags)
    end

    @spec get_by_id(integer) :: nil | Platform.Article.t()
    def get_by_id(id) do
        Repo.get_by(__MODULE__, id: id) |> Repo.preload(:tags)
    end

    @spec with_tags(Platform.Article.t() | [Platform.Article.t()]) :: Platform.Article.t()
    def with_tags(articles) when is_list(articles) do
        articles |> Repo.preload(:tags)
    end

    def with_tags(article) do
        article |> Repo.preload(:tags)
    end

    @spec all :: [] | [Platform.Article.t()]
    def all(), do: Repo.all(__MODULE__) |> Repo.preload(:tags)

    @spec all_active :: [] | [Platform.Article.t()]
    def all_active() do
        from(a in Platform.Article, where: a.active == true) |> Repo.all |> Repo.preload(:tags)
    end

    @spec delete(__MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, Ecto.Changeset.t()}
    def delete(%__MODULE__{} = article), do: article |> Repo.delete

    @spec get_twitter_share_url(nil | Platform.Article.t()) :: binary
    def get_twitter_share_url(nil) do
        "http://twitter.com/share?url=https://mihaiblebea.com&hashtags=mihaiblebea"
    end

    def get_twitter_share_url(%__MODULE__{} = article) do
        "http://twitter.com/share?text=#{ article.description }&url=https://mihaiblebea.com/article/#{ article.slug }&hashtags=mihaiblebea"
    end

    @spec get_linkedin_share_url(nil | Platform.Article.t()) :: binary
    def get_linkedin_share_url(nil) do
        "https://www.linkedin.com/shareArticle?mini=true&url=https://mihaiblebea.com"
    end

    def get_linkedin_share_url(%__MODULE__{} = article) do
        "https://www.linkedin.com/shareArticle?mini=true&url=https://mihaiblebea.com/article/#{ article.slug }&title=#{ article.title }&summary=#{ article.description }&source="
    end

    @spec get_facebook_share_url(nil | Platform.Article.t()) :: binary
    def get_facebook_share_url(nil) do
        "https://www.facebook.com/sharer/sharer.php?u=https://mihaiblebea.com"
    end

    def get_facebook_share_url(%__MODULE__{} = article) do
        "https://www.facebook.com/sharer/sharer.php?u=https://mihaiblebea.com/article/#{ article.slug }"
    end
end
