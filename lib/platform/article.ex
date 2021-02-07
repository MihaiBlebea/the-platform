defmodule Platform.Article do
    use Ecto.Schema
    import Ecto.Changeset

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    schema "articles" do
        field :content_url, :string
        field :image_url, :string
        field :description, :string
        field :slug, :string
        field :subtitle, :string
        field :title, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(article, attrs) do
        article
        |> cast(attrs, [:title, :subtitle, :description, :image_url, :content_url, :slug])
        |> validate_required([:title, :subtitle, :description, :image_url, :content_url, :slug])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(article) do
        changeset(%__MODULE__{}, article)
        |> Repo.insert
    end

    @spec get_by_slug(any) :: nil | Platform.Article.t()
    def get_by_slug(slug) do
        Repo.get_by(__MODULE__, slug: slug)
    end

    @spec all :: [] | [Platform.Article.t()]
    def all(), do: Repo.all(__MODULE__)

    @spec fetch_content(nil | Platform.Article.t()) :: nil | binary
    def fetch_content(%__MODULE__{} = article) do
        {:ok, %{body: body, status_code: code}} = article.content_url |> HTTPoison.get
        case code do
            200 -> body
            _ -> nil
        end
    end

    def fetch_content(nil), do: nil

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
