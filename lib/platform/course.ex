defmodule Platform.Course do
    use Ecto.Schema
    import Ecto.Changeset

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    schema "courses" do
        field :description, :string
        field :slug, :string
        field :title, :string

        timestamps()
    end


    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(course, attrs) do
        course
        |> cast(attrs, [:title, :slug, :description])
        |> validate_required([:title, :slug, :description])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(course) do
        changeset(%__MODULE__{}, course)
        |> Repo.insert
    end

    @spec all :: [] | [Platform.Course.t()]
    def all(), do: Repo.all(__MODULE__)

    @spec get_by_slug(any) :: nil | Platform.Course.t()
    def get_by_slug(slug) do
        Repo.get_by(__MODULE__, slug: slug)
    end
end
