defmodule Platform.ArticleTag do
    use Ecto.Schema

    import Ecto.Changeset

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    @primary_key false
    schema "article_tag" do
        field :article_id, :integer
        field :tag_id, :integer
        # belongs_to(:article, Article, primary_key: true)
        # belongs_to(:tag, Tag, primary_key: true)

        timestamps()
    end

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
