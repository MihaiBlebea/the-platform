defmodule Platform.PageView do
    use Ecto.Schema
    import Ecto.Changeset

    @type t() :: %__MODULE__{}

    schema "page_views" do
        field :url, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(page_view, attrs) do
        page_view
        |> cast(attrs, [:url])
        |> validate_required([:url])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(page_view) do
        changeset(%__MODULE__{}, page_view)
        |> Platform.Repo.insert
    end
end
