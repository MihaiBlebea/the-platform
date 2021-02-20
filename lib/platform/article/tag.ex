defmodule Platform.Tag do
    use Ecto.Schema

    import Ecto.{Changeset, Query}

    alias Platform.{Repo, Article, Tag}

    @type t() :: %__MODULE__{}

    schema "tags" do
        field :active, :boolean, default: false
        field :label, :string

        timestamps()

        many_to_many(:articles, Article, join_through: "article_tag")
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(tag, attrs) do
        tag
        |> cast(attrs, [:label, :active])
        |> validate_required([:label, :active])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(tag) do
        changeset(%__MODULE__{}, tag)
        |> Repo.insert
    end

    @spec all :: [] | [__MODULE__.t()]
    def all(), do: Repo.all(__MODULE__)

    @spec get_by_id(integer) :: nil | Tag.t()
    def get_by_id(id) do
        Repo.get_by(__MODULE__, id: id) |> Repo.preload(:articles)
    end

    @spec get_by_label(binary) :: nil | Tag.t()
    def get_by_label(label) do
        Repo.get_by(__MODULE__, label: label) |> Repo.preload(:articles)
    end

    @spec get_in_id_list(list) :: [Tag.t()]
    def get_in_id_list(ids) do
        from(t in Tag, where: t.id in ^ids) |> Repo.all
    end
end
