defmodule Platform.ArticleTag do
    use Ecto.Schema

    import Ecto.Changeset

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    @primary_key false
    schema "article_tag" do
        belongs_to(:article, Platform.Article, primary_key: true)
        belongs_to(:tag, Platform.Tag, primary_key: true)
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(article_tag, attrs) do
        article_tag
        |> cast(attrs, [:article_id, :tag_id])
        |> validate_required([:article_id, :tag_id])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(article_tag) do
        changeset(%__MODULE__{}, article_tag)
        |> Repo.insert
    end
end
